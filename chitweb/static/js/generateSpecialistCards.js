//Defining a function that builds DOM (card) for each user
function specialistCard(specialist, rootBlock) {
    
    const userCard = document.createElement('div');
    userCard.className =  'col-md-4 col-lg-3 col-sm-10 col-11 user-card';
    
    const blockUser = document.createElement('div');
    blockUser.className = 'block-user';

    const imgUser = document.createElement('img');
    imgUser.className = 'img-user';
    imgUser.src = "./static/images/default-profile.png" //should be changed to specialist.photo;

    const blockUserDescription = document.createElement('div');

    const blockUserDescriptionName = document.createElement('h5');
    blockUserDescriptionName.textContent = specialist.last_name + ' ' + specialist.first_name;
    const blockUserDescriptionShortBio = document.createElement('p');
    blockUserDescriptionShortBio.textContent = specialist.short_bio
    
    window.onload = specialist.specializations
        .forEach(specialityAPI => {
            fetch(specialityAPI)
            .then(resp => resp.json())
            .then(speciality => {
                
                const blockUserDescriptionSpecialization = document.createElement('span');
                blockUserDescriptionSpecialization.textContent = speciality.title;
                blockUserDescription.appendChild(blockUserDescriptionSpecialization);
            })
            .catch(error => {
                console.log("Error fetching specialization API")
            });
        })

    const blockSocial = document.createElement('div');
    blockSocial.className = 'block-social';
    
    const linkTelegram = document.createElement("a");
    linkTelegram.setAttribute("href", "https://www.t.me/" + specialist.telegram)

    const iconTelegram = document.createElement('img');
    iconTelegram.className = 'icon-social';
    iconTelegram.src = "./static/images/social/telegram.png";

    const linkGithub = document.createElement("a");
    linkGithub.setAttribute("href", "https://www.github.com/" + specialist.github)

    const iconGithub = document.createElement('img');
    iconGithub.className = 'icon-social';
    iconGithub.src = "./static/images/social/github.png";
 
    
    rootBlock.appendChild(userCard);
    userCard.appendChild(blockUser);
    blockUser.appendChild(imgUser);
    blockUser.appendChild(blockUserDescription);
    blockUserDescription.appendChild(blockUserDescriptionName);
    blockUserDescription.appendChild(blockUserDescriptionShortBio);
   
    
    userCard.appendChild(blockSocial);
    blockSocial.appendChild(linkTelegram);
    linkTelegram.appendChild(iconTelegram);
    blockSocial.appendChild(linkGithub);
    linkGithub.appendChild(iconGithub);
   
  };

  //Specialist cards are attached to the element Id="specialistCards"
  
 const bodyChitcom = document.getElementById('specialistCards');
 
 let urlSpecialists = "/api/specialists/?format=json";
 
 window.onload = fetch(urlSpecialists, {
       method: 'GET',
       //mode: 'no-cors',
       headers:{
           'Content-Type':'application/json'
       }
   }) // Call the fetch function passing the url of the API as a parameter
   .then(resp => resp.json())
   .then(data => {
     // Code for handling the data you get from the API
 
     data.results.forEach(specialist => {
     
         specialistCard(specialist, bodyChitcom);
        
     });  
   })
   .catch(error => {
       // This is where you run code if the server returns any errors
       console.log("Something went wrong with fetch")
   });
   