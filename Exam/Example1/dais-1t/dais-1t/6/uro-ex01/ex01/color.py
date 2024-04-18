#------------------------------------------------------------------------------#
# ColorChooser and Dialog                                                      #
#------------------------------------------------------------------------------#
from Tkinter import *
from tkMessageBox import *
from tkColorChooser import askcolor              
from tkFileDialog   import askopenfilename      

class myApp:
  def __init__(self, master):
    self.fr = Frame(master)
    self.en = Entry(self.fr)
    self.bv = Button(self.fr, text="Barva", width=10, command=self.barva)
    self.bz = Button(self.fr, text="Zprava", width=10, command=self.msg)
    self.fr.pack()
    self.en.pack(side="top", padx=4, pady=4, fill="x")
    self.bv.pack(side="left", pady=4)
    self.bz.pack(side="right", pady=4)
    self.fr.master.title("Color")
  def barva(self):
    self.color=askcolor()
    self.en.delete(0,END)
    self.en.insert(0,self.color)
  def msg(self):
    showerror('Spam', "Barva")
     
root = Tk()
app = myApp(root)
root.mainloop()
#------------------------------------------------------------------------------#

