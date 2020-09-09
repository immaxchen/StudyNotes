import sys
import PIL.Image

ASCII_CHARS = list("@#S%?*+;:,.")

def resize_image(image, new_width):
    width, height = image.size
    ratio = height / width / 2
    new_height = int(new_width * ratio)
    resized_image = image.resize((new_width, new_height))
    return resized_image

def grayify(image):
    grayscale_image = image.convert("L")
    return grayscale_image

def image_to_ascii(image, width):
    pixels = grayify(resize_image(image.getdata(), width))
    chars = "".join([ASCII_CHARS[pixel // 25] for pixel in pixels])
    length = len(chars)
    ascii = "\n".join(chars[i:i + width] for i in range(0, length, width))
    return ascii

if __name__ == "__main__":

    try:
        path = sys.argv[1]
        width = int(sys.argv[2])
        image = PIL.Image.open(path)
        ascii = image_to_ascii(image, width)
        print(ascii)
    except IndexError:
        print("missing argument: (1) image file path (2) output width")
    except ValueError:
        print(f"invalid number: {sys.argv[2]}")
    except OSError:
        print(f"error opening file: {path}")

