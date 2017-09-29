import time
import win32ui
import subprocess
import datetime

def IsRunning(WindowName):
	try:
		#Check if the server is running
		if win32ui.FindWindow(None, WindowName):
			print("Everything appears to be normal!")
			return True
		#end if
	except win32ui.error:
		#Restart server
		print("Server not running, restarting...")
		subprocess.Popen(["start", "/wait", "cmd", "/c", "ServerStart.bat"], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
		return False
	#end try/except
#end IsRunning()

#Begin main program
try:
	while True:
		print(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S') + ": Checking server status...")
		IsRunning("OneMinecraftServer")
		time.sleep(60)
	#end while
except KeyboardInterrupt:
	pass
#end try/except
#End main program
