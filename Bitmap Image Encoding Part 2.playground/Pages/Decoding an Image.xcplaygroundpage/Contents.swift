//: [Previous](@previous) / [Next](@next)
//: # Decoding an Image
//: The following two statements are required to make the playground run. Please do not remove.
import Cocoa
import PlaygroundSupport
/*:
 ## Decoding the text
 Now we will (at last!) decode the image.
 
 Recall, our rules are:
 
 * If a line starts with a 0, the first pixel is black.
 * If a line does not start with a 0, the first pixel is white.
 * When a comma is encountered, a new number begins, and the colour switches.
 * When a newline character is encountered, go to a new row in the image.
 * Once we have a new number, we draw that many pixels in the current colour.
 
 First, copy and paste your encoded image string to this page.
*/

// Copy your encoded image string here...
let encodedBitmap = """
w20
w20
w3,b2,w2,b6,w2,b2,w3
w2,b5,w6,b5,w2
w1,b4,w5,b0,w5,b4,w1
w1,b3,w6,b0,w6,b3,w1
w1,b3,w2,b3,w2,b3,w2,b3,w1
w2,b1,w2,b2,g1,b1,w2,b1,g1,b2,w2,b1,w2
w2,b1,w2,b3,w4,b3,w2,b1,w2
w2,b1,w1,p1,b2,w2,b2,w2,b2,p1,w1,b1,w2
w2,b1,w1,p2,w3,b2,w3,p2,w1,b1,w2
w2,b1,w7,w7,b1,w2
w2,b1,w3,b8,w3,b1,w2
w3,b3,e2,b1,e2,b1,e2,b3,w3
w4,b1,e3,b1,e2,b1,e3,b1,w4
w4,b1,e5,e5,b1,w4
w5,b1,e8,b1,w5
w6,b8,w6
r1,w1,r1,w1,r1,w1,r1,w1,r1,w1,r1,w1,r1,w1,r1,w1,r1,w1,r1,w1
r5,r5,r5,r5
"""

// Make a canvas
let canvas = Canvas(width: 402, height: 402)

// Make a grid
// NOTE: The code that builds the grid was tucked away in something called a *function* to keep things tidy. We'll learn about functions later.
drawGrid(on: canvas)

// Start drawing at left
var x = 0

// Set the size of a "pixel"
let cellSize = 20

// Keep track of current colour
var currentColor = "white"


// Start drawing at top of grid
var y = canvas.height - cellSize - 2

// Store the current number of pixels to draw
var drawThisManyPixels = 0

// Iterate over each character in the encoded bitmap string
for character in encodedBitmap {
    
    // Set colour at start of a line
    if character == "0" {
        
        canvas.fillColor = Color.black
        currentColor = "black"

    } else if character == "," {
        
        // We have a new number
        // Are we past the first pixel in a row?
        if x > 0 {

            // Toggle the pixel colour
            if currentColor == "black" {
                currentColor = "white"
                canvas.fillColor = Color.white
            } else {
                currentColor = "black"
                canvas.fillColor = Color.black
            }

        }
        
    } else if character == "\n" {
        
        // We are on a new line, so reduce the vertical position
        // and reset the horizontal position
        y = y - cellSize
        x = 0
        
        // Default colour after new line is white
        canvas.fillColor = Color.white
        currentColor = "white"
        
    } else if character == "w" {
        canvas.fillColor = Color.white
    } else if character == "b" {
        canvas.fillColor = Color.black
    } else if character == "g" {
        canvas.fillColor = Color.init(hue: 8, saturation: 6, brightness: 38, alpha: 75)
    } else if character == "p" {
        canvas.fillColor = Color.init(hue: 357, saturation: 49, brightness: 99, alpha: 65)
    } else if character == "e"{
        canvas.fillColor = Color.init(hue: 31, saturation: 40, brightness: 86, alpha: 50)
    } else if character == "r"{
        canvas.fillColor = Color.green
    } else {
        
        // Get the new number of pixels to draw
        drawThisManyPixels = Int(String(character))!
        
        // Draw the pixels
        for _ in 1...drawThisManyPixels {

            // Draw the enlarged "pixel"
            canvas.drawRectangle(bottomLeftX: x, bottomLeftY: y, width: cellSize, height: cellSize)
            
            // Increase x so that the next pixel is drawn to the right of this one
            x += cellSize

        }

    }
    
}



/*:
 ### Check the results
 Does the output match what you'd expect, based on the values in the encoded string?
 
 How do you know?
 
 Write your ideas in the code comment below.
 */

// I notice that...
// I know this because...

/*:
 ## Extension
 Now that you have an understanding of how if statements (also called *selection* statements or *conditional* statements) work... extend this code.
 
 How could you adjust the rules so that pixels can be rendered in colour?
 
 What additions or changes would you need to make to the code above?
 
 Work with a partner to discuss possibilities and then make the changes in code.
 */


/*:
 Now, **remember to commit and push your work**.
 */
/*:
 ## Template code
 The code below is necessary to see results in the Assistant Editor at right. Please do not remove.
 */
PlaygroundPage.current.liveView = canvas.imageView
