require 'tk'

class Translation
    def initialize
        @@message = ""
        @filename = ""
        @code = ""
        @morse = Hash['A'=> '.-',
            'B'=> '-…',
            'C'=> '-.-.',
            'D'=> '-..',
            'E'=> '.',
            'F'=> '..-.',
            'G'=> '--.',
            'H'=> '....',
            'I'=> '..',
            'J'=> '.---',
            'K'=> '-.-',
            'L'=> '.-..',
            'M'=> '--',
            'N'=> '-.',
            'O'=> '---',
            'P'=> '.--.',
            'Q'=> '--.-',
            'R'=> '.-.',
            'S'=> '...',
            'T'=> '-',
            'U'=> '..-',
            'V'=> '...-',
            'W'=> '.--', 
            'X'=> '-..-', 
            'Y'=> '-.--',
            'Z'=> '--.',
            'N1'=> '.----',
            'N2'=> '..---',
            'N3'=> '...--',
            'N4'=> '....-',
            'N5'=> '.....',
            'N6'=> '-....',
            'N7'=> '--...',
            'N8'=> '---..',
            'N9'=> '----.',
            'N0'=> '-----']

############## Root ##############

        $root = TkRoot.new do                   #window
            title "Encryption"
            background "#A3BCFF"
            minsize(800, 350)
        end

############## Frames ##############

        $savePack = TkFrame.new($root) do       #save and load
            background "#5784FF"
            padx 20
            pady 80
            pack(side: 'right')
        end

        $choices = TkFrame.new($root) do         #encoding 
            background "#5784FF"
            padx 30
            pady 65
            pack(side: 'left')
        end

        $messageWindow = TkFrame.new($root) do      #messageWindow
            background "#4569CC"
            padx 5
            pady 80
            pack(side: 'left')
        end

############## Message Label ##############
        
        $preview = TkLabel.new($messageWindow) do       #preview Box
            text "#{@@message}"
            font TkFont.new('times 15 bold')
            width 100
            height 10
            wraplength 700
            grid(column: 0, row: 0)
        end
        $preview.configure("text"=>"#{@final}")

        $response = TkLabel.new($messageWindow) do
            background "#4569CC"
            text ""
            font TkFont.new('times 10')
            width 20
            height 2
            wraplength 200
            grid(column: 0, row: 1)
        end
        
############## Entries ##############

        @filename = TkEntry.new($savePack) do       #filename Box
            font TkFont.new('times 10 bold')
            width 21
            grid(column: 0, row: 3)
        end
        @filename.value = "message.txt"

############## String Methods ##############

        morseEncode = proc do                           #morseEncode
            @final = ""

            begin
                @@message = @@message.downcase!
                @@message = @@message.upcase!
                
                @@message.each_char do |i|
                    value = i.ord
        
                    if value.between?(65, 90)
                        @final = @final + @morse[i] + " "
                    elsif value == 32
                        @final = @final + " "
                    end
                end

                @@message = @final
                $preview.configure("text"=>"#{@final}")
                $response.configure("text"=>"")
            rescue => exception
                $response.configure("text"=>"Couldn't translate")
            end
        end

        morseDecode = proc do                           #morseDecode
            @final = ""

            begin
                @@message = @@message.split("  ")
                @@message.map! {|i| i.split(' ')}
        
                @@message.each do |i|
                    i.each do |j|
                        @final = @final + @morse.key(j).to_s
                    end
                    @final += " "
                end
                @@message = @final
                $preview.configure("text"=>"#{@final}")
                $response.configure("text"=>"")
            rescue => exception
                $response.configure("text"=>"Couldn't translate")
            end

        end

        shiftForward = proc do                         #shiftForward
            @final = ""

            begin
                @@message = @@message.downcase!
                @@message = @@message.upcase! 
    
                @@message.each_char do |i|
                    value = i.ord
                    if value.between?(65, 90)
                        ascii = value + 1
                        if (ascii == 91)
                            ascii = 65
                        end
                        letter = ascii.chr
                        @final = @final + letter
                    elsif value == 32
                        @final = @final + " "
                    else
                        @final = @final + i
                    end
                end
                @@message = @final
                $preview.configure("text"=>"#{@final}")
                $response.configure("text"=>"")
            rescue => exception
                $response.configure("text"=>"Couldn't translate")
            end

        end

        shiftBackward = proc do                        #shiftBackwards
            @final = ""

            begin
                @@message = @@message.downcase!
                @@message = @@message.upcase! 
    
                @@message.each_char do |i|
                    value = i.ord
                    if value.between?(65, 90)
                        ascii = value - 1
                        if (ascii == 64)
                            ascii = 90
                        end
                        letter = ascii.chr
                        @final = @final + letter
                    elsif value == 32
                        @final = @final + " "
                    else
                        @final = @final + i
                    end
                end
                @@message = @final
                $preview.configure("text"=>"#{@final}")
                $response.configure("text"=>"")
            rescue => exception
                $response.configure("text"=>"Couldn't translate")
            end
        end

        removeVowels = proc do                      #removeVowels
            @final = ""

            begin
                @@message.each_char do |i|
                    value = i.ord
                    if (value == 65 || value == 69 || value == 73 || value == 79 || value == 85 || value == 97 || value == 101 || value == 105 || value == 111 || value == 117)
                        #nothing
                    else
                        @final = @final + i
                    end
                end
                @@message = @final
                $preview.configure("text"=>"#{@final}")
            rescue => exception
                $response.configure("text"=>"Couldn't translate")
            end
        end

        flip = proc do                              #flip
           begin
                @final = @@message.reverse!

                @@message = @final
                $preview.configure("text"=>"#{@final}")
           rescue => exception
                $response.configure("text"=>"Couldn't translate")
           end
        end

        binary = proc do                            #binary
            @final = ""

            @@message.each_char do |i|
                value = i.ord
                value = value.to_s(2)
                @final = @final + value
            end
            @@message = @final
            $preview.configure("text"=>"#{@final}")
        end

        hex = proc do                            #binary
            @final = ""

            @@message.each_char do |i|
                value = i.ord 
                value = value.to_s(16)
                @final = @final + value
            end
            @@message = @final
            $preview.configure("text"=>"#{@final}")
        end

############## Buttons ##############

        @morseEncodeButton = TkButton.new($choices) {   #morse Encode Button
            text "Morse Encryption"
            command morseEncode
            pady = 25
            grid(column: 0, row: 0)
        }

        @morseDecodeButton = TkButton.new($choices) {   #morse Decode Button
            text "Morse Decryption"
            command morseDecode
            pady = 25
            grid(column: 0, row: 1)
        }

        @caesarForwardsButton = TkButton.new($choices) {    #shift Forward Button
            text "Shift Forward"
            command shiftForward
            pady = 25
            grid(column: 0, row: 2)
        }

        @caesarBackwardsButton = TkButton.new($choices) {   #shift Backward Button
            text "Shift Backward"
            command shiftBackward
            pady = 25
            grid(column: 0, row: 3)
        }

        @removeVowelsButton = TkButton.new($choices) {      #removeVowels Button
            text "Remove Vowels"
            command removeVowels
            pady = 25
            grid(column: 0, row: 4)
        }

        @flipButton = TkButton.new($choices) {              #flip Button
            text "Flip Text"
            command flip
            pady = 25
            grid(column: 0, row: 5)
        }

        @binaryButton = TkButton.new($choices) {            #binary Button
            text "Convert to Binary"
            command binary
            pady = 25
            grid(column: 0, row: 6)
        }

        @hexButton = TkButton.new($choices) {            #hex Button
            text "Convert to Hex"
            command hex
            pady = 25
            grid(column: 0, row: 7)
        }

############## Save & Load ##############
        $files = TkLabel.new($savePack) do
            background "#5784FF"
            foreground "#000"
            text "File Selection"
            font TkFont.new('times 10 bold')
            grid(column: 0, row: 0)
        end

        saveMessage = proc do                           #save file
            if File.exists?(@filename.value)
                puts "file found"
            end

            file = File.open(@filename.value, "w")
            file.puts @@message
            $response.configure("text"=>"File Saved")
            file.close
        end
        
        loadMessage = proc do                           #load file
            file = File.open(@filename.value, "r")
            @@message = file.read
            file.close
            $preview.configure("text"=>"#{@@message}")
            $response.configure("text"=>"File Loaded")
        end

        @save = TkButton.new($savePack) {           #save Button 
            text 'Save'
            command saveMessage
            pady = 10
            grid(column: 0, row: 1)
        }

        @load = TkButton.new($savePack) {           #load Button
            text 'Load'
            command loadMessage
            pady = 10
            grid(column: 0, row: 2)
        }

############## Radio Button ##############
        $color = TkLabel.new($savePack) do
            background "#5784FF"
            foreground "#000"
            text "Change Color"
            font TkFont.new('times 10 bold')
            grid(column: 1, row: 0)
        end

        blue = proc do
            $root.configure('background'=>'#A3BCFF')
            $savePack.configure('background'=>'#5784FF')
            $color.configure('background'=>'#5784FF')
            $files.configure('background'=>'#5784FF')
            $choices.configure('background'=>'#5784FF')
            $messageWindow.configure('background'=>'#4569CC')
            $response.configure('background'=>'#4569CC')
        end

        red = proc do
            $root.configure('background'=>'#FF8985')
            $savePack.configure('background'=>'#FF3F38')
            $color.configure('background'=>'#FF3F38')
            $files.configure('background'=>'#FF3F38')
            $choices.configure('background'=>'#FF3F38')
            $messageWindow.configure('background'=>'#CC312D')
            $response.configure('background'=>'#CC312D')
        end

        green = proc do
            $root.configure('background'=>'#CFFFE3')
            $savePack.configure('background'=>'#82FFB6')
            $color.configure('background'=>'#82FFB6')
            $files.configure('background'=>'#82FFB6')
            $choices.configure('background'=>'#82FFB6')
            $messageWindow.configure('background'=>'#68CC92')
            $response.configure('background'=>'#68CC92')
        end

        @blueButton = TkRadioButton.new($savePack) do
            text "blue"
            command blue 
            grid(column: 1, row: 1)
        end

        @redButton = TkRadioButton.new($savePack) do
            text "red"
            command red 
            grid(column: 1, row: 2)
        end

        @greenButton = TkRadioButton.new($savePack) do
            text "green"
            command green 
            grid(column: 1, row: 3)
        end
    end
end

Translation.new
Tk.mainloop