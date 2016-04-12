// Response to post:
// http://www.statalist.org/forums/forum/general-stata-discussion/general/1334612-identifying-computer-based-on-host-name-and-set-path-to-specific-directory
// The extended macro function : environment will allow you to access environmental 
// variables on the system which should point to either C:/Users/mm597, /Users/mm597, 
// or /home/mm597 for non-*nix based OS, OSX, and/or Linux/Unix.  
// 

if `"`c(username)'"' == "mm597" cd `"`: env HOME'/UNI/EB/REE/"'
else cd `"~/Desktop/MY_FILES/1.PROFESSIONAL/UNI/EB/REE/"'

