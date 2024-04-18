# -*- coding: utf-8 -*-
#------------------------------------------------------------------------------#
# Pouziti OptionMenu                                                    Nemec  #
#------------------------------------------------------------------------------#
from Tkinter import *
import Tix

class myApp:

  def fce(self, prom):
    self.la.configure(text=prom)
    
  def __init__(self, master):

    self.la = Label(master, text="nic", foreground="red")
    self.la.pack()
    self.prom = StringVar(master)
    self.option = Tix.Control(master,label="volba:",integer=TRUE, min=0, max=50, command = self.fce)
    self.option.pack()
    self.bu = Button(master, text="Button")
    self.bu.pack()



root = Tix.Tk()
app = myApp(root)
root.mainloop()

#------------------------------------------------------------------------------#



