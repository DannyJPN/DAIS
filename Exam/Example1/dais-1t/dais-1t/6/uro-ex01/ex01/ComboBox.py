# -*- coding: utf-8 -*-
#------------------------------------------------------------------------------#
# Pouziti OptionMenu                                                    Nemec  #
#------------------------------------------------------------------------------#
from Tkinter import *
import Tix

class myApp:

  def fce(self, var):
    self.la.configure(text=self.prom.get())
    
  def __init__(self, master):

    self.la = Label(master, text="nic", foreground="red")
    self.la.pack()
    self.prom = StringVar(master)
    self.option = Tix.ComboBox(master,dropdown=TRUE)
    self.option.pack()
    self.option.insert(END, "Prvni")
    self.option.insert(END, "Druhy")



root = Tix.Tk()
app = myApp(root)
root.mainloop()

#------------------------------------------------------------------------------#



