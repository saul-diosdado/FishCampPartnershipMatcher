let multipleChoiceForm = document.getElementById("multiple-choice-form");
let typeSelector = document.getElementById("question_question_type");

showHideMultipleChoice();
typeSelector.addEventListener("change", showHideMultipleChoice);

function showHideMultipleChoice() {
    if (typeSelector.value === "Multiple Choice") {
        multipleChoiceForm.style.display = "block";
    } else {
        multipleChoiceForm.style.display = "none";
    }
}
