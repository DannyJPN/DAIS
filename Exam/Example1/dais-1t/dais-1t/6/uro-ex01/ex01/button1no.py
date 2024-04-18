#------------------------------------------------------------------------------#
# Obycejne tlacitko, aplikace zde neni trida                        e.s. 2004  #
#------------------------------------------------------------------------------#
from Tkinter import *

top = Tk()
b = Button(top, text="Konec", command=top.quit)
top.title("Button 1")
b.pack()

top.mainloop()
#------------------------------------------------------------------------------#



