Drag-Menu
=========

A drag-to-reveal menu that allow user to drag at somewhere and see a menu show up. The drag menu will stick at the point that user dragged, configurable if you want it's center to stick at a point.  

As a League of Legends lover, I made an example to show that how i customize it and make it like the radial ping menu in League of Legends. Thinking to add ping sound and notification for user lol  

In addition, I also wrote some code to show that how to restrict a pointer view within a radius. It may suitable for making a virtual D-Pad or something.  

![ScreenShot](https://github.com/Seitk/Drag-Menu/blob/master/Drag%20Menu/resources/screenshot1.png?raw=true)  
![ScreenShot](https://github.com/Seitk/Drag-Menu/blob/master/Drag%20Menu/resources/screenshot2.png?raw=true) &nbsp; ![ScreenShot](https://github.com/Seitk/Drag-Menu/blob/master/Drag%20Menu/resources/screenshot3.png?raw=true)

Usage  
Just simply include DragMenuView.h, add it into the TOP of your view. Then register a UIPanGestureRecognizer in a draggable view. Reminded that this will use your drag gesture so that it is not compatible with your scrollviews .

Example:

UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragEvent:)];  
[panGR setMaximumNumberOfTouches:1];  
[panGR setMinimumNumberOfTouches:1];  
[self.view addGestureRecognizer:panGR];  
  
Dont forget to implement the pan gesture callback and pass it to my drag menu  

\- (void) dragEvent:(UIPanGestureRecognizer *)panGR  
{  
    [demoDMView dragEvent:panGR];  
}  
  
Contribute  
I'd love to include your contributions. Feel free to improve it, send comments or suggestions. Please let me know if you have great idea on it.

Contact Me  
You can add me on Facebook - http://www.facebook.com/seitkk
