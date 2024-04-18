#------------------------------------------------------------------------------#
# Notebook                                                              Nemec  #
#------------------------------------------------------------------------------#

from Tkinter import *
import Tix 

class myApp:
  def __init__(self, master):
    self.nb = Tix.NoteBook(master)
    self.nb.add("page1", label="Prvni")
    self.nb.add("page2", label="Druhe")

    self.p1 = self.nb.subwidget_list["page1"]
    self.p2 = self.nb.subwidget_list["page2"]


    self.nb.pack(expand=1, fill=BOTH)
    
    #A1 
    self.la1 = Label(self.p1, text="Prvni okno")
    self.la1.pack()

    #B1
    self.la2 = Label(self.p2, text="Druhe okno")
    self.la2.pack()

root = Tix.Tk()
app = myApp(root)
root.mainloop()
root.destroy()
