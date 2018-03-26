import sys#系统相关的信息模块
import threading
from threading import Timer
import serial
import serial.tools.list_ports
from PyQt5 import QtWidgets, QtCore, QtSerialPort
from PyQt5.QtCore import QCoreApplication
from PyQt5.QtCore import QVariant
from PyQt5.QtCore import QTimer
from UI import Ui_MainWindow

class mywindow(QtWidgets.QMainWindow,Ui_MainWindow):#继承QWidget
    global ser
    ser = serial.Serial()

    def __init__(self):
        super(mywindow,self).__init__()
        self.setupUi(self)
        
        #***************Parameter Setting Start*****************************************
        self.comboBox_port.mysignal.connect(self.comboBox_port_Search_Handle)
        self.comboBox_port.activated.connect(self.comboBox_port_Selection_Handle)

        self.comboBox_baudrate.addItem("600",600)
        self.comboBox_baudrate.addItem("1200",1200)
        self.comboBox_baudrate.addItem("4800",4800)
        self.comboBox_baudrate.addItem("9600",9600)
        self.comboBox_baudrate.addItem("19200",19200)
        self.comboBox_baudrate.addItem("38400",38400)
        self.comboBox_baudrate.addItem("57600",57600)
        self.comboBox_baudrate.addItem("115200",115200)
        self.comboBox_baudrate.activated.connect(self.comboBox_baudrate_Selection_Handle)
        self.comboBox_baudrate.setCurrentText("9600")
        ser.baudrate = 9600

        self.comboBox_bytesize.addItem("5 bit",5)
        self.comboBox_bytesize.addItem("6 bit",6)
        self.comboBox_bytesize.addItem("7 bit",7)
        self.comboBox_bytesize.addItem("8 bit",8)
        self.comboBox_bytesize.activated.connect(self.comboBox_bytesize_Selection_Handle)
        self.comboBox_bytesize.setCurrentText("8 bit")
        ser.bytesize = serial.EIGHTBITS
        
        self.comboBox_parity.addItem("NONE",0)
        self.comboBox_parity.addItem("EVEN",1)
        self.comboBox_parity.addItem("ODD",2)
        self.comboBox_parity.activated.connect(self.comboBox_parity_Selection_Handle)
        self.comboBox_parity.setCurrentText("NONE")
        ser.parity = serial.PARITY_NONE

        self.comboBox_stopbits.addItem("1 bit",0)
        self.comboBox_stopbits.addItem("1.5 bit",1)
        self.comboBox_stopbits.addItem("2 bit",2)
        self.comboBox_stopbits.activated.connect(self.comboBox_stopbits_Selection_Handle)
        self.comboBox_stopbits.setCurrentText("1 bit")
        ser.stopbits = serial.STOPBITS_ONE

        self.lineEdit_timeout.textChanged.connect(self.lineEdit_timeout_Input_Handle)
        self.lineEdit_timeout.setText("0")
        ser.timeout = 0

        self.checkBox_xonxoff.stateChanged.connect(self.checkBox_xonxoff_Input_Handle)
        self.checkBox_rtscts.stateChanged.connect(self.checkBox_rtscts_Input_Handle)
        self.checkBox_dsrdtr.stateChanged.connect(self.checkBox_dsrdtr_Input_Handle)
        self.xonxoff  = False
        self.rtscts = False
        self.dsrdtr = False
        
        self.pushButton_openport.clicked.connect(self.pushButton_openport_Handle)
        self.pushButton_closeport.clicked.connect(self.pushButton_closeport_Handle)

        #********************Parameter Setting End**************************************
        self.pushButton_send.clicked.connect(self.pushButton_send_Handle)
        self.pushButton_reset_tx.clicked.connect(self.pushButton_reset_tx_Handle)
        self.pushButton_reset_rx.clicked.connect(self.pushButton_reset_rx_Handle)
        
        global timer_rx
        timer_rx = QTimer()
        timer_rx.setInterval(500)
        timer_rx.timeout.connect(self.looptimer_rx_Handle)
        self.radioButton_disable_receive.clicked.connect(timer_rx.stop)
        self.radioButton_enable_receive.clicked.connect(timer_rx.start)
        
        global timer_tx
        timer_tx = QTimer()
        timer_tx.setInterval(1000)
        timer_tx.timeout.connect(self.looptimer_tx_Handle)
        self.radioButton_manual_send.clicked.connect(timer_tx.stop)
        self.radioButton_auto_send.clicked.connect(timer_tx.start)

        self.radioButton_enable_receive.setChecked(True)
        self.radioButton_hex_display.setChecked(True)
        self.radioButton_manual_send.setChecked(True)
        self.radioButton_hex_send.setChecked(True)
        timer_rx.start()
    def comboBox_port_Search_Handle(self):
        self.comboBox_port.clear()
        port_list = list(serial.tools.list_ports.comports())
        length = len(port_list)
        if  length > 0:
            for i in range(0,length):
                port_temp = list(port_list[i])
                self.comboBox_port.addItem(port_temp[0])
                
    def comboBox_port_Selection_Handle(self):
        ser.port = self.comboBox_port.currentText()
        print("port=",ser.port)
            
    def comboBox_baudrate_Selection_Handle(self):
        ser.baudrate = self.comboBox_baudrate.currentData()
        print("baudrate=", ser.baudrate)
        if ser.is_open:
            settings = ser.get_settings()
            ser.apply_settings(settings)
            
    def comboBox_bytesize_Selection_Handle(self):
        bytesize = self.comboBox_bytesize.currentData()
        if bytesize == 5:
            ser.bytesize = serial.FIVEBITS
        elif bytesize == 6:
            ser.bytesize = serial.SIXBITS
        elif bytesize == 7:
            ser.bytesize = serial.SEVENBITS
        elif bytesize == 8:
            ser.bytesize = serial.EIGHTBITS
        print("bytesize=", ser.bytesize)
        if ser.is_open:
            settings = ser.get_settings()
            ser.apply_settings(settings)
            
    def comboBox_parity_Selection_Handle(self):
        Parity = self.comboBox_parity.currentData()
        print("parity=", Parity)
        if ser.is_open:
            settings = ser.get_settings()
            ser.apply_settings(settings)
            
    def comboBox_stopbits_Selection_Handle(self):
        StopBits = self.comboBox_stopbits.currentData()
        print("stopbits=", StopBits)
        if ser.is_open:
            settings = ser.get_settings()
            ser.apply_settings(settings)
            
    def lineEdit_timeout_Input_Handle(self):
        str1 = self.lineEdit_timeout.text()
        if str1.isdigit():
            Timeout = float(str1)
            print("timeout=",Timeout," seconds")
        else:
            print("timeout=invalid input")
        if ser.is_open:
            settings = ser.get_settings()
            ser.apply_settings(settings)
            
    def checkBox_xonxoff_Input_Handle(self):
        Xonxoff = self.checkBox_xonxoff.checkState()
        print("xonxoff=", Xonxoff)
        if ser.is_open:
            settings = ser.get_settings()
            ser.apply_settings(settings)
            
    def checkBox_rtscts_Input_Handle(self):
        Rtscts = self.checkBox_rtscts.checkState()
        print("rtscts=", Rtscts)
        if ser.is_open:
            settings = ser.get_settings()
            ser.apply_settings(settings)        
        
    def checkBox_dsrdtr_Input_Handle(self):
        Dsrdtr = self.checkBox_dsrdtr.checkState()
        print("dsrdtr=", Dsrdtr)
        if ser.is_open:
            settings = ser.get_settings()
            ser.apply_settings(settings)
            
    def pushButton_openport_Handle(self):
        if ser.is_open:
            print("serial already opened")
        else:
            ser.open()
            print("opening serial")
            
    def pushButton_closeport_Handle(self):
        if ser.is_open:
            ser.close()
            print("closing serial")
            
    def pushButton_send_Handle(self):
        send_str = self.textEdit_transmit.toPlainText()
        if self.radioButton_hex_send.isChecked():
            send_list = send_str.split()
            num = len(send_list)
            print(send_list)
            print(num)
            str_temp = send_list[0]
            for i in range(1,num):
                str_temp = str_temp + send_list[i]
            print(str_temp)
            try:
                send_bytes = bytes.fromhex(str_temp)
            except:
                print("invalid hex input")
            
        elif self.radioButton_ascii_send.isChecked():
            send_bytes = bytes(send_str, encoding = "utf8")
        if ser.is_open:
            try:
                cnt = ser.write(send_bytes)
                cnt = cnt + self.lcdNumber_tx.intValue()
                self.lcdNumber_tx.display(cnt)
            except:
                print("send data is null")
    def pushButton_reset_tx_Handle(self):
        self.lcdNumber_tx.display(0)
        if ser.is_open:
            ser.reset_output_buffer()
            
    def looptimer_rx_Handle(self):
        if ser.is_open:
            rx_num = ser.inWaiting()
            if rx_num != 0:
                self.textBrowser_receive.insertPlainText(" ")
                data = ser.read(rx_num)
                if self.radioButton_hex_display.isChecked(): 
                    for i in range(0,rx_num):
                        hexstr = hex(data[i])
                        if hexstr.split("x")[1].isalpha():
                            newstr = hexstr.split("x")[0] + "x" + hexstr.split("x")[1].upper()
                        else:
                            newstr = hexstr                                                                           
                        self.textBrowser_receive.insertPlainText(newstr + " ")
                elif self.radioButton_ascii_display.isChecked():
                    dis_str = str(data, encoding = "utf-8")  
                    self.textBrowser_receive.insertPlainText(dis_str)
                totalnum = rx_num + self.lcdNumber_rx.intValue()
                self.lcdNumber_rx.display(totalnum)
            
    def pushButton_reset_rx_Handle(self):
        self.lcdNumber_rx.display(0)
        self.textBrowser_receive.clear()
        if ser.is_open:
            ser.reset_input_buffer()
            
    def looptimer_tx_Handle(self):
        if self.radioButton_auto_send.isChecked():
            send_str = self.textEdit_transmit.toPlainText()
            if self.radioButton_hex_send.isChecked():
                send_list = send_str.split()
                num = len(send_list)
                print(send_list)
                print(num)
                str_temp = send_list[0]
                for i in range(1,num):
                    str_temp = str_temp + send_list[i]
                print(str_temp)
                try:
                    send_bytes = bytes.fromhex(str_temp)
                except:
                    print("invalid hex input")
                
            elif self.radioButton_ascii_send.isChecked():
                send_bytes = bytes(send_str, encoding = "utf8")
            if ser.is_open:
                try:
                    cnt = ser.write(send_bytes)
                    cnt = cnt + self.lcdNumber_tx.intValue()
                    self.lcdNumber_tx.display(cnt)
                except:
                    print("send data is null")

if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    myshow = mywindow()
    myshow.show()
    sys.exit(app.exec_())
