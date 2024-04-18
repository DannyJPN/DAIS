#------------------------------------------------------------------------------#
# Tlacitko s vlastnim fontem                                        e.s. 2004  #
#------------------------------------------------------------------------------#
from Tkinter import *
import tkFont

class myApp:
  def __init__(self, master):
    self.fr = Frame(master)
    self.myFont = tkFont.Font(family="Helvetica", weight="bold", slant="italic")
    #self.la.configure(font=self.newFont)  
    self.bu = Button(self.fr, text="Konec", font=self.myFont, foreground="red", width=10, command=master.quit)
    master.title("Button 3")
    self.fr.pack()
    self.bu.pack(padx=8, pady=8)
     
root = Tk()
app = myApp(root)
root.mainloop()
#------------------------------------------------------------------------------#

