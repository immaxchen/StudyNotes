# coding: utf-8

import sys
import pexpect

def main():

    username = "YOUR_USERNAME"
    password = "YOUR_PASSWORD"

    shcmd = "ssh -oBatchMode=no -oStrictHostKeyChecking=no bbsu@ptt.cc"
    child = pexpect.spawn(shcmd, maxread=9999, encoding="utf-8", codec_errors="ignore")
    child.logfile = sys.stdout

    child.expect("請輸入代號")
    child.send(username + "\r")
    child.expect("請輸入您的密碼")
    child.send(password + "\r")

    ptn_list = [
        "您想刪除其他重複登入的連線嗎", # N\r
        "您要刪除以上錯誤嘗試的記錄嗎", # N\r
        "密碼不對喔", # exit
        "裡沒有這個人啦", # exit
        "請勿頻繁登入以免造成系統過度負荷", # \r
        "請按任意鍵繼續", # \r
        "oodbye", # exit
    ]

    while True:
        res = child.expect(ptn_list)
        if res in [0, 1]:
            child.send("N\r")
        elif res in [4, 5]:
            child.send("\r")
        elif res in [2, 3, 6]:
            return

if __name__ == '__main__':

    main()

