#!/bin/env python3

import psutil

processString='Xvnc'
maxCount=2
users = {}

for p in psutil.process_iter():
  if processString in p.name() or processString in ' '.join(p.cmdline()):
    username = p.username()
    create_time_usec = int(str(p.create_time()).replace('.',''))
    p_pid = p.pid
    data_tup = (p_pid,create_time_usec)
    if username not in users:
      users[username]=[]
    users[username].append(data_tup)

# now we have all the pids and create_times in dictionary users.., let's sort it using lambda expression:

for user in users:
  users[user].sort(key=lambda tup: tup[1])

for user in users:
  sessions_count = len(users[user])
  if sessions_count <= maxCount:
    continue
  print("user " + str(user) + " has more than 2 vnc session -> let's kill the oldest")
  for session_n in range(sessions_count-2):
    pid=int(users[user][session_n][0])
    print("killing pid " + str(pid))
    p = psutil.Process(pid)
    p.terminate()
