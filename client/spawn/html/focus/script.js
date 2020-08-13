$("document").ready(function() {

    window.addEventListener("message", function(e) {
        var item = event.data;
        if (item.ui === "main_menu") {
            if (item.status == true) {
                $("#main_menu").toggleClass("hidden");
            }  
        }
    })

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

    $("#load_character").click(function() {
        $.post("http://sr_main/load_character", JSON.stringify({}));
        $("#main_menu").toggleClass("hidden");
        $("#load_character_ui").toggleClass("hidden");
    });

    document.onkeyup = function(data) {
        if (data.which == 27) { //ESC Key
            $(".container").toggleClass("hidden");
            $.post("http://sr_main/NUIFocusOff", JSON.stringify({}));
        }
    }
})