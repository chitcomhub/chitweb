//Finding DOM element with id="dropdownSpecialization"
//get specializations from an API and add each speciality as an option to dropdown

const dropdown = document.getElementById('dropdownSpecialization');

//Creating dropdown variable which is going to have values of all the specializations
let dropdownOption = document.createElement("option");
//Specialization value 0 is a standard specialization (gives all the specializations)
dropdownOption.value = 0;
dropdownOption.textContent = "Любая";
dropdown.appendChild(dropdownOption);

const url = '/api/specializations/?format=json';

window.onload = fetch(url)
    .then(res => res.json())
    .then(data => {
        data.results.forEach(speciality => {
            //Looping through the list of specializations
            dropdownOption = document.createElement("option");
            dropdownOption.value = speciality.id;
            dropdownOption.textContent = speciality.title;
            dropdown.appendChild(dropdownOption);
        })
    })
    .catch(error => {
        console.log("Problems fetching specializations for dropdown-menu. Following error: " + error)
    });
