# import EK80Example
#
# test = EK80Example.initialize()
# test.EK80Example()


import datetime
import sys
import threading

import EK80Example
# import matlab.engine
from PyQt5 import QtCore
from PyQt5.QtWidgets import QApplication, QMainWindow

import ek80_ui

from ek80_tools import Ek80_run


def get_date_time():
    time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    return '\n' + time


def load_engine():
    log_edit.append(get_date_time() + "： 正在加载matlab引擎，请稍后...")
    log_edit.moveCursor(log_edit.textCursor().End)
    app.processEvents()
    try:
        global eng
        eng = EK80Example.initialize()
        print("finish engine starting")
        log_edit.append(get_date_time() + "： 引擎加载完成！可以开始读取EK80 RAW文件。")
        log_edit.moveCursor(log_edit.textCursor().End)
        app.processEvents()
    except Exception as e:

        eng = None
        log_edit.append(get_date_time() + "： 引擎加载失败！失败原因为：" + e.__str__())
        log_edit.moveCursor(log_edit.textCursor().End)
        app.processEvents()
    return eng


def readRAW():
    global eng
    if eng is not None:
        try:
            log_edit.append(get_date_time() + "： 开始读取文件，请注意弹出的窗口...")
            log_edit.moveCursor(log_edit.textCursor().End)
            app.processEvents()
            log_edit.append(get_date_time() + "： 响应时间与您的输入以及电脑配置有关，请耐心等待...")
            log_edit.moveCursor(log_edit.textCursor().End)
            app.processEvents()

            eng.EK80Example(nargout=0)

            log_edit.append(get_date_time() + "： RAW文件读取完成！请查看输出的sp、sv图！")
            log_edit.moveCursor(log_edit.textCursor().End)
            app.processEvents()
        except Exception as e:
            log_edit.append(get_date_time() + "： 出现错误：" + e.__str__())
            log_edit.moveCursor(log_edit.textCursor().End)
            app.processEvents()
    else:
        log_edit.append(get_date_time() + "：未找到matlab引擎，请先加载引擎！")
        log_edit.moveCursor(log_edit.textCursor().End)
        app.processEvents()
    # print(tf)


def load_engine_thread():
    log_edit.append(get_date_time() + "： 线程启动成功")
    log_edit.moveCursor(log_edit.textCursor().End)
    app.processEvents()
    load_engine()


def run_read_thread():
    log_edit.append(get_date_time() + "： 读取线程启动成功")
    log_edit.moveCursor(log_edit.textCursor().End)
    app.processEvents()
    readRAW()


def f1():
    t = threading.Thread(target=load_engine_thread)
    t.setDaemon(True)  # 把子进程设置为守护线程, 保证在父进程结束后立即退出
    t.start()


def f2():
    t = threading.Thread(target=run_read_thread)
    t.setDaemon(True)  # 把子进程设置为守护线程, 保证在父进程结束后立即退出
    t.start()


if __name__ == '__main__':

    # test = EK80Example.initialize()

    RUNNING_MODE = 0

    # DEBUG_MODE_1
    if RUNNING_MODE == 1:
        eng = matlab.engine.start_matlab()
        tf = eng.EK80Example(nargout=0)

    # DEBUG_MODE_2
    elif RUNNING_MODE == 2:
        eng = matlab.engine.start_matlab()
        RawData = eng.ReadEK80Data(nargout=1)
        BasicProcessedData = eng.BasicProcessData(RawData, nargout=1)
        spFigureHandle, svFigureHandle = eng.CreateEchograms(BasicProcessedData, nargout=2)

    # DEBUG_MODE_3
    elif RUNNING_MODE == 3:
        test = EK80Example.initialize()
        test.EK80Example()
    else:

        eng = None
        # 高分辨率支持
        QtCore.QCoreApplication.setAttribute(QtCore.Qt.AA_EnableHighDpiScaling)

        app = QApplication(sys.argv)
        MainWindow = QMainWindow()
        ui = ek80_ui.Ui_MainWindow()
        ui.setupUi(MainWindow)

        load_engine_button = ui.pushButton_load_engine
        start_button = ui.pushButton
        log_edit = ui.textBrowser_log

        load_engine_button.clicked.connect(f1)
        start_button.clicked.connect(f2)

        # 禁止最大、最小化按钮
        MainWindow.setWindowFlags(QtCore.Qt.WindowCloseButtonHint)
        # 禁止拉伸窗口大小
        MainWindow.setFixedSize(MainWindow.width(), MainWindow.height())
        MainWindow.show()
        sys.exit(app.exec_())
