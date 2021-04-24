#!/usr/bin/env python3
import i3ipc

i3=i3ipc.Connection()

def main():

    i3.on("window::move", rename)
    i3.on("window::new", rename)
    i3.on("window::title", rename)
    i3.on("window::close", rename)
    i3.main()

def rename(i3,e):
    static_workspaces=[1,2,3,4,5,10]
    for i in i3.get_tree().workspaces():
        if i.num not in static_workspaces:
            icon=""
            for j in i.leaves():
                windows=j.window_class
                if(windows=="FreeTube"):
                    icon=""
                if(windows=="Microsoft Teams - Preview"):
                    icon=""
                if(windows=="VirtualBox Manager"):
                    icon="歷"
                
            i3.command('rename workspace "%s" to "%s"'%(i.name,icon))

    
if __name__ == "__main__":
    main()           