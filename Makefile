ifneq ($(KERNELRELEASE),)
# kbuild part of the makefile
obj-m += hello1.o
obj-m += hello2.o

ccflags-y += -g  # Adds debugging information

else
# Normal makefile
KDIR ?= /lib/modules/$(shell uname -r)/build
INCDIR ?= /home/cripo/repos/busybox/_install/root/test1/inc  # Specify the directory for hello1.h

default:
	$(MAKE) -C $(KDIR) M=$(PWD) EXTRA_CFLAGS="-I$(INCDIR)"  # Pass include directory
	cp hello1.ko hello1.ko.unstripped
	cp hello2.ko hello2.ko.unstripped
	strip -g hello1.ko
	strip -g hello2.ko

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
endif



