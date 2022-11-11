
$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
            return;
        } else {
            $("#container").hide();
        }
    }
    display(false)


    window.addEventListener('message', function(event) {
        var item = event.data;
        $("#name").html(item.playerName);
        $("#playerid").html(item.playerId);
        $("#playerjob").html(item.PlayerJob);
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)


            } else {
                display(false)

            }

        }
    })




    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('https://rw-ticketsystem/exit', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        $.post('https://rw-ticketsystem/exit', JSON.stringify({}));
        return
    })


    $("#submit").click(function () {
        let title = $("#tittel").val();
        let description = $("#detaljer").val();

        if (!title.length >= 75) {
            $("#errorMSG").html("Du har for mye tekst i tittelen!").addClass("error-msg");
            return

        } else if
         (!description.length >= 450) {
            $("#errorMSG").html("Du har for mye tekst i beskrivelsen!").addClass("error-msg");
            return
            
        } else if (title < 3){
            $("#errorMSG").html("Du har ikke fylt ut alt!").addClass("error-msg");
            return

        } else if (description < 5){
            $("#errorMSG").html("Du har ikke fylt ut alt!").addClass("error-msg");
            return
            
        }
        // if there are no errors from above, we can send the data back to the original callback and handle it from there
        $.post('https://rw-ticketsystem/main', JSON.stringify({
            description: description,
            title: title,
        }));
        return;
    })
})



//     //when the user clicks on the submit button, it will run
//     $("#submit").click(function () {
//         let inputValue = $("#tittel").val()
//         if (inputValue.length >= 200) {
//             $.post("https://rw-ticketsystem/error", JSON.stringify({
//                 error: "Input was greater than 100"
//             }))
//             return
//         } else if (!inputValue) {
//             $.post("https://rw-ticketsystem/error", JSON.stringify({
//                 error: "Du har ikke skrevet inn noe i feltene"
//             }))
//             return
//         }
//         // if there are no errors from above, we can send the data back to the original callback and hanndle it from there
//         $.post('https://rw-ticketsystem/main', JSON.stringify({
//             text: inputValue,
//         }));
//         return;
//     })
// })