# caesar_web.rb

require 'sinatra'
require 'sinatra/reloader' if development?

configure do
    set :views => './views',
        :root => '.',
        :port => 5450
end

get '/' do
    ciphertext = nil
    erb :index, :locals => {:ciphertext => ciphertext}
end

post '/' do
    plaintext = params['plaintext']
    shift = params['shift'].to_i
    ciphertext = caesar_cipher(plaintext, shift)

    # return the same view but with the ciphertext
    erb :index, :locals => {:ciphertext => ciphertext}
end

def caesar_cipher plaintext, shift

    # check that shift is an integer
    if !shift.integer?
        return "Shift value is not an integer"
    end

    # split plaintext into array and perform shift
    ciphertext = Array.new
    plaintext.chars.each do |chr|
        if chr.match(/^[[:alpha:]]$/)
            shift.times do
                chr.next!
            end
            ciphertext.push(chr.reverse.chr)
        else
            ciphertext.push(chr)
        end
    end
    return ciphertext.join()
end