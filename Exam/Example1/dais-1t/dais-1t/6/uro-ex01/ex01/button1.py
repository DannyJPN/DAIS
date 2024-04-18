#------------------------------------------------------------------------------#
# Obycejne tlacitko                                                 e.s. 2004  #
#------------------------------------------------------------------------------#
from Tkinter import *

class myApp:
  def __init__(self, master):
    self.fr = Frame(master)
    self.bu = Button(self.fr, text="Konec", command=self.fr.quit)
    self.fr.master.title("Button1")
    self.fr.pack()
    self.bu.pack()

root = Tk()
app = myApp(root)
root.mainloop()
#------------------------------------------------------------------------------#



