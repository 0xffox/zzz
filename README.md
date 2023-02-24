# About
zzz is better sleep. It allows to see how much time already elapsed and how much time remains.
It is also complete Pomodoro console app.

# Usage
To time 25 minutes just type:
```bash
$ zzz 25m
  56s elapsed [==\.......................................................] 24m04s remains
```
It is ideal for time tracking. To start 25 minutes of 'Very important task` type:
```bash
$ zzz 25m Very important task
01m46s elapsed [====/Very important task.................................] 23m14s remains
```
Not only will it indicate current task you doing while it runs, it will also log them to your ~/.zzz-history file.

To get summary of what you've been doing for, for example, last 6 hours, type:
```bash
$ zzz 6h --stats
47.27 %     05m55s      Very important task
  .39 %        03s      not important task
32.62 %     04m05s      <no-task>
  .13 %        01s      important task
19.30 %     02m25s      some task
  .26 %        02s      other
```

# Install
Copy zzz script inside one of your PATH directories and make it executable.

