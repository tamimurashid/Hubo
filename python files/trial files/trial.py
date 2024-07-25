import os
import mictest as mc
from gtts_speaker import speak
import speech_recognition as sr
import webbrowser
import pywhatkit

def greet():
    recognizer = sr.Recognizer()
    microphone = sr.Microphone()
    speak("Hi there! My name is hubo. What can I call you?")

    with microphone as source:
        print("Say something!")
        recognizer.adjust_for_ambient_noise(source)
        audio = recognizer.listen(source)

    try:
        recognized_text = recognizer.recognize_google(audio)
        print("You said:", recognized_text)
        speak(f"You said your name is {recognized_text}")
    except sr.UnknownValueError:
        print("Could not understand audio")
    except sr.RequestError as e:
        print("Could not request results; {0}".format(e))

def ask_question():
    recognizer = sr.Recognizer()
    microphone = sr.Microphone()
    speak("Ask me anything")

    with microphone as source:
        print("Ask me anything!")
        recognizer.adjust_for_ambient_noise(source)
        audio = recognizer.listen(source)

    try:
        recognized_text = recognizer.recognize_google(audio)
        print("You asked:", recognized_text)
        speak(f"You asked: {recognized_text}")
    except sr.UnknownValueError:
        print("Could not understand audio")
    except sr.RequestError as e:
        print("Could not request results; {0}".format(e))

    if "search Wikipedia for" in recognized_text.lower():
        query = recognized_text.lower().replace("search wikipedia for", "")
        speak(f"Searching Wikipedia for {query}")
        # Search Wikipedia code here
    elif "search YouTube for" in recognized_text.lower():
        query = recognized_text.lower().replace("search youtube for", "")
        speak(f"Searching YouTube for {query}")
        webbrowser.open(f"https://www.youtube.com/results?search_query={query}")
    elif "play music" in recognized_text.lower():
        speak("What song would you like me to play?")
        song = input("Enter song name: ")
        speak(f"Playing {song}")
        pywhatkit.playonyt(song)

onpro = True
while onpro:
    greet()
    ask_question()
