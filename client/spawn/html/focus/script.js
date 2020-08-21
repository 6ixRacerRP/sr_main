$("document").ready(function() {

    window.addEventListener("message", function(e) {
        var item = event.data;
        // Toggle the main menu
        if (item.ui === "main_menu") {
            if (item.status == true) {
                $("#main_menu").toggleClass("hidden");
            }
        } 
        
        // Deciding whether or not to show new_character button
        if (item.num_characters < 4) {
            $("#new_character").click(function() {
                $("#main_menu").toggleClass("hidden");
                $("#new_character_ui").toggleClass("hidden");
                $("#submit").click(function() {
                    var first_name_val = $("#first_name").val();
                    var last_name_val = $("#last_name").val();
                    var appearance_val = $("input:radio[name='appearance']:checked").val();
                    if (first_name_val === "" || last_name_val === "" || appearance_val == undefined) {
                        $.post("http://sr_main/invalid_input", JSON.stringify({}));
                    } else {
                        $("#new_character_ui").toggleClass("hidden")
                        $.post("http://sr_main/new_character", JSON.stringify({
                            first_name : first_name_val,
                            last_name  : last_name_val,
                            appearance : appearance_val
                        }));
                    }
                });
            });
        } else if (item.num_characters >= 4) {
            $("#new_character").toggleClass("disabled");
        }

        // Don't show load_character button if there are 0 characters
        if (item.num_characters == 0) {
            $("#load_character").toggleClass("disabled");
        } else if (item.num_characters > 0) {
            $("#load_character").click(function() {
                $.post("http://sr_main/load_character", JSON.stringify({}));
            });
        }

        // if characters array exists, it's because user has clicked load_characters, and thus load characters
        if (item.characters) {
            $("#main_menu").toggleClass("hidden");
            $("#load_character_ui").toggleClass("hidden");

            for (i = 0; i < item.characters.length; i++) {
                var characterbox = "#box" + i + " .character";
                var charinfo = item.characters[i];
                $(characterbox).toggleClass("hidden");
                $(characterbox + " h3").html(charinfo.first_name + " " + charinfo.last_name);
                $(characterbox + " .number").html("<b>#:</b> " + charinfo.phone_number);
                $(characterbox + " .cash").html("<b>Cash:</b> " + charinfo.cash);
                $(characterbox + " .bank").html("<b>Bank:</b> " + charinfo.bank);
                $(characterbox + " .play_button p").html(charinfo.id);
                $(characterbox + " .delete_button p").html(charinfo.id);
            }
        } 

        // Play character and Load character functionality
        $(".play_button").click(function() {
            var id = $(".play_button p").html();
            $(".container").toggleClass("hidden");
            $.post("http://sr_main/spawn_character", JSON.stringify({
                id  : id
            }))
        })

        $(".delete_button").click(function() {
            var id = $(".delete_button p").html();
            $("#load_character_ui").toggleClass("hidden");
            $("#main_menu").toggleClass("hidden");
            $.post("http://sr_main/delete_character", JSON.stringify({
                id  : id
            }))
        })
        
    })

    document.onkeyup = function(data) {
        if (data.which == 27) { //ESC Key
            $(".container").toggleClass("hidden");
            $.post("http://sr_main/NUIFocusOff", JSON.stringify({}));
        }
    }
})