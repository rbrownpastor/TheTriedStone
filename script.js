<script>
const track = document.querySelector('.carousel-track');
const images = document.querySelectorAll('.carousel img');
const prevBtn = document.querySelector('.prev');
const nextBtn = document.querySelector('.next');

let index = 1; // Start with Sunset in center

function updateCarousel() {
  const width = images[0].clientWidth + 20; // include gap
  track.style.transform = `translateX(-${index * width}px)`;

  images.forEach(img => img.classList.remove('active'));
  if (images[index]) images[index].classList.add('active');
}

nextBtn.onclick = () => {
  index = (index + 1) % images.length;
  updateCarousel();
};

prevBtn.onclick = () => {
  index = (index - 1 + images.length) % images.length;
  updateCarousel();
};

/* AUTO SCROLL */
setInterval(() => {
  index = (index + 1) % images.length;
  updateCarousel();
}, 4000);

updateCarousel();
</script>
