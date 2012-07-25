(* Module String2 *)

let string_of_char = Char.escaped

let char_of_string s = String.get s 0

let split s =
  let rec split s accu = 
    let len = String.length s in
      if len = 0 then List.rev accu 
      else split (String.sub s 1 (len-1)) ((String.sub s 0 1) :: accu)
  in
    split s []
      
let join l = 
  let rec join l accu = 
    match l with
      | [] -> accu
      | c :: rest -> join rest (accu ^ c)
  in
    join l ""

let split_char s =
  let rec split_char s accu = 
    let len = String.length s in
      if len = 0 then List.rev accu 
      else split_char (String.sub s 1 (len-1)) ((char_of_string(String.sub s 0 1)) :: accu)
  in
    split_char s []
      
let join_char l = 
  let rec join_char l accu = 
    match l with
      | [] -> accu
      | c :: rest -> join_char rest (accu ^ c)
  in
    join_char l ""


let escape_char = function
  | "<" -> "&lt;"
  | ">" -> "&gt;"
  | "&" -> "&amp;"
  | "\"" -> "&quot;"
  | _ as c -> c

let html_entities s =
  join (List.map escape_char (split s))

let encode_url s =
  let encode_char = function
    | " " -> "%20"
    | ":" -> "%3A"
    | "<" -> "%3C"
    | ">" -> "%3E"
    | "/" -> "%2F"
    | _ as c -> c
  in
    join (List.map encode_char (split s))

let show s =
  let show_char = function
    | ' ' -> "_"
    | '\n' -> "N"
    | '\r' -> "R"
    | _ as c -> string_of_char c
  in
    join (List.map show_char (split_char s))

let clean_newline s = 
  let clean_newline_char = function
    | '\r' -> ""
    | _ as c -> string_of_char c
  in join (List.map clean_newline_char (split_char s))
       
let rec ignore_char ic n =
  if n > 0 then begin
    ignore (input_char ic) ;
    ignore_char ic (n - 1)
  end
