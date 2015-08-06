from flask import render_template, request, url_for 
from app import app

@app.route('/')
def index():
 import subprocess
 cmd = subprocess.Popen(['ps','aux'],stdout=subprocess.PIPE,stderr=subprocess.PIPE)
 stdout,error = cmd.communicate()
 memory = stdout.splitlines()        
 return render_template('index.html', memory=memory)

@app.route('/output', methods = ['POST'])
def output():
	type = request.form['inputCategory']
	action1 = request.form['inputAction1']
	if str(action1) != '':
		action = action1
	action2 = request.form['inputAction2']
	if str(action2) != '':
                action = action2
	action3 = request.form['inputAction3']
	if str(action3) != '':
                action = action3
	user = request.form['inputUser']
	userhome = request.form['inputHomeDir']	
	newpass = request.form['inputNewPass']
	if str(userhome) != '':
		user4tharg = userhome
#	newpass = request.form['inputNewPass']
	elif str(newpass) != '':
		user4tharg = newpass
	else:
		user4tharg = ''
	import subprocess
		
	cmd = subprocess.Popen(['sudo','bash','/usr/local/flask-workshop/scripts/users.sh',user,type,action,user4tharg],stdout=subprocess.PIPE,stderr=subprocess.PIPE)
	stdout,error = cmd.communicate()
	userscriptout = stdout.splitlines()
	return render_template('output.html', action=action, type=type, user=user, user4tharg=user4tharg, userscriptout=userscriptout)

