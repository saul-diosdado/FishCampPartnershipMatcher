let buttonsContainer = document.getElementById("buttons-container");
let choicesContainer = document.getElementById("choices-container");
let typeSelector = document.getElementById("question_question_type");

typeSelector.addEventListener("change", () => {
    if (typeSelector.value === "Multiple Choice") {
        createAndAppendAddDeleteButton();
    } else {
        deleteAndRemoveDynamicElements();
    }
});

function createAndAppendAddDeleteButton() {
    let addButton = document.createElement("button");
    addButton.textContent = "Add Choice";
    addButton.setAttribute("type", "button");
    addButton.addEventListener("click", addChoice);
    buttonsContainer.appendChild(addButton);

    let deleteButton = document.createElement("button");
    deleteButton.textContent = "Delete Choice";
    deleteButton.setAttribute("type", "button");
    deleteButton.addEventListener("click", removeChoice);
    buttonsContainer.appendChild(deleteButton);

    // Add one field to start off with.
    addChoice();
}

function deleteAndRemoveDynamicElements() {
    while (buttonsContainer.firstChild) {
        buttonsContainer.removeChild(buttonsContainer.firstChild);
    }
    while (choicesContainer.firstChild) {
        choicesContainer.removeChild(choicesContainer.firstChild);
    }
}

function addChoice() {
    let choiceDiv = document.createElement("div");
    choiceDiv.setAttribute("class", "container-choice");
    choicesContainer.appendChild(choiceDiv);

    let choiceField = document.createElement("input");
    choiceField.setAttribute("class", "input-choice-field");
    choiceField.setAttribute("id", "choice-" + choicesContainer.childElementCount);

    let choiceLabel = document.createElement("label");
    choiceLabel.textContent = choicesContainer.childElementCount;

    choiceDiv.appendChild(choiceLabel);
    choiceDiv.appendChild(choiceField);
}

function removeChoice() {
    if (choicesContainer.childElementCount != 0) {
        choicesContainer.removeChild(choicesContainer.lastChild);
    }
}
