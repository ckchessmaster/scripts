import time
import win32ui
import subprocess
import datetime

def IsRunning(WindowName):
	try:
		if win32ui.FindWindow(None, WindowName):
			print("Everything appears to be normal!")
			return True
	except win32ui.error:
		print("Server not running, restarting...")
		subprocess.Popen(["start", "/wait", "cmd", "/c", "ServerStart.bat"], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
		return False

try:
	while True:
		print(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S') + ": Checking server status...")
		IsRunning("OneMinecraftServer")
		time.sleep(60)
except KeyboardInterrupt:
	pass
	
	
	
	
