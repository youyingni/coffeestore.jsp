document.addEventListener("DOMContentLoaded", () => {
    const cards = document.querySelectorAll(".hot-sale-card");
    let currentIndex = 0;
  
    const switchCard = () => {
      // Hide the current card
      cards[currentIndex].classList.remove("active");
  
      // Update the index
      currentIndex = (currentIndex + 1) % cards.length;
  
      // Show the next card
      cards[currentIndex].classList.add("active");
    };
  
    // Set interval to automatically switch cards every 5 seconds
    setInterval(switchCard, 5000);
  });
  

  document.querySelectorAll(".carousel-indicators button").forEach((btn, index) => {
    btn.addEventListener("click", () => {
      // Remove active class from all slides and buttons
      document.querySelectorAll(".hot-sale-card").forEach(card => card.classList.remove("active"));
      document.querySelectorAll(".carousel-indicators button").forEach(button => button.classList.remove("active"));
      
      // Add active class to clicked button and corresponding slide
      document.querySelectorAll(".hot-sale-card")[index].classList.add("active");
      btn.classList.add("active");
    });
  });
  