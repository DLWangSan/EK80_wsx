# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'ek80.ui'
#
# Created by: PyQt5 UI code generator 5.15.0
#
# WARNING: Any manual changes made to this file will be lost when pyuic5 is
# run again.  Do not edit this file unless you know what you are doing.


from PyQt5 import QtCore, QtGui, QtWidgets


class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(352, 349)
        self.centralwidget = QtWidgets.QWidget(MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.textBrowser_log = QtWidgets.QTextBrowser(self.centralwidget)
        self.textBrowser_log.setGeometry(QtCore.QRect(40, 160, 256, 151))
        self.textBrowser_log.setAcceptRichText(False)
        self.textBrowser_log.setObjectName("textBrowser_log")
        self.label = QtWidgets.QLabel(self.centralwidget)
        self.label.setGeometry(QtCore.QRect(40, 130, 54, 12))
        self.label.setObjectName("label")
        self.pushButton_load_engine = QtWidgets.QPushButton(self.centralwidget)
        self.pushButton_load_engine.setGeometry(QtCore.QRect(110, 30, 121, 31))
        self.pushButton_load_engine.setObjectName("pushButton_load_engine")
        self.pushButton = QtWidgets.QPushButton(self.centralwidget)
        self.pushButton.setGeometry(QtCore.QRect(110, 80, 121, 31))
        self.pushButton.setObjectName("pushButton")
        MainWindow.setCentralWidget(self.centralwidget)
        self.statusbar = QtWidgets.QStatusBar(MainWindow)
        self.statusbar.setObjectName("statusbar")
        MainWindow.setStatusBar(self.statusbar)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "EK80"))
        self.label.setText(_translate("MainWindow", "实时日志"))
        self.pushButton_load_engine.setText(_translate("MainWindow", "加载matlab引擎"))
        self.pushButton.setText(_translate("MainWindow", "读取EK80文件"))
