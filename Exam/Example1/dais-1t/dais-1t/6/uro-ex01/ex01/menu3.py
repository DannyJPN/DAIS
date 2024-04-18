#------------------------------------------------------------------------------#
# Akceleratory                                                      e.s. 2004  #
#------------------------------------------------------------------------------#
from Tkinter import *
import tkMessageBox

class myApp:
  def __init__(self, master):
    self.fr = Frame(master)
    self.ca = Canvas(self.fr, width=250, height=150)
    self.menubar = Menu(self.fr)
    
    self.filemenu = Menu(self.menubar, tearoff=0)
    self.filemenu.add_command(label="Neco", underline=0, command=self.neco)
    self.filemenu.add_separator()
    self.filemenu.add_command(label="Quit", underline=0,
         accelerator="<Ctrl-c>", command=master.quit)
    self.menubar.add_cascade(label="File", menu=self.filemenu)

    master.title("Menu 3")
    master.config(menu=self.menubar)
    self.fr.pack()
    self.ca.pack()

    master.bind("<Button-1>", self.showFileMenu)
    master.bind("<Key-F1>", self.showMessage)
    master.bind("<Control-c>", self.appExit)

  def neco(self):
    pass
  def showFileMenu(self, event):
    self.filemenu.post(event.x_root, event.y_root)
  def showMessage(self, event):
    tkMessageBox.showinfo("Info", "URO leto 2003-4...", )
  def appExit(self, event):
    self.fr.quit()
     
root = Tk()
app = myApp(root)
root.mainloop()
#------------------------------------------------------------------------------#

