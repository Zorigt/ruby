#!/usr/local/bin/ruby
# Author: Douglas Putnam
# Module: cgi_helper.rb
#
#=CgiHelper
#The <tt>CgiHelper</tt> module contains a couple of useful functions that make creating web scripts a little easier.
#- http_header()  # prints the Content-type lines correctly)
#- render()       # processes text as ERB code)
#- doctype()      # returns a valid DOCTYPE
# 
#==Usage
#
#   #!/usr/local/bin/ruby
#   require 'cgi_helper'
#   include CgiHelper
#   
#   # print the Content-type lines
#   http_header('text/plain','xhtml_strict')
#   
#   # Create some HTML to feed to render() 
#   html = <<HTML
#   This will be the HTML that I want to print. Any Ruby code
#   will be embedded with ERB tags (<% tags %>).
#   HTML
#   
#   # Display the output  
#   puts render(HTML)
# 
# *OUTPUT*
#
#  Content-type: text/plain
#  This will be the HTML that I want to print. Any Ruby code
#  will be embedded with ERB tags (<% #ruby code %>).
#
# ----
require 'rubygems'
require 'cgi'
require 'erb'
module CGI_Helper

  #These DOCTYPES are copied from http://www.w3.org/QA/2002/04/valid-dtd-list.html.
  # 
  #DOCTYPES are used with every valid HTML document. The DOCTYPE is used by the web browser to
  #process and format the HTML according to a prescribed set of rules. If a DOCTYPE is not present,
  #browsers do their best to interpret the document, but often introduce unexpected quirks into the
  #process. 
  #
  #Be aware that all of thise XHTML DOCTYPES include the &lt;html&gt; tag.
  @@doctypes = {
    :html5 => '<!doctype html><html lang="en-us">',
    :xhtml_strict => '<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">',
    :xhtml_transitional => '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">',
    :html4str => '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
    "http://www.w3.org/TR/html4/strict.dtd">
<html>',
    :loose => '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/strict.dtd">
<html>',
    :html4l => '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>',
    :transitional =>'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>',
    :html4tr =>'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>',
    :frameset  => '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
    "http://www.w3.org/TR/html4/frameset.dtd">
<html>',
    :html4fr  => '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
    "http://www.w3.org/TR/html4/frameset.dtd">
<html>',
    :html_3 => '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>'
  }

  # This is a good function for printing HTML safely
  def h(html)
    CGI.escapeHTML(html)
  end

  # This is a convenience function that prints the Content-type, DOCTYPE, and <html> tag.
  def http_header(mode='text/html',doc=:html5)
    puts 'Content-type: ' + mode
    puts
    #puts doctype(doc)
  end

  # This method will process text as ERB code and return the result. 
  def render(html)
    require 'erb'
    erb = ERB.new(html)
    erb.result(binding)
  end

  # The doctype() method returns XHTML Transitional by default.
  def doctype(type = 'html5')
    @@doctypes[type.to_sym]
  end

end

if $0 == 'cgi_helper.rb'
  include CGI_Helper
  http_header('text/html','html5')
html = <<HTML
This will be the HTML that I want to print. Any Ruby code
will be embedded with ERB tags (&lt;% #ruby code %&gt;).
HTML
puts render(html)
end