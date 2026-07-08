//Welcome alert for landing page
window.onload = function () {
  if (document.body.id === "landing-page") {
    alert("Happy Customer! Welcome to our coffee store");
  }
};

document.addEventListener("DOMContentLoaded", () => {

 
  // Mobile Navigation Toggle
  
  const hamburger = document.getElementById("hamburger");
  const nav = document.querySelector("#nav");

  if (hamburger && nav) {
    hamburger.addEventListener("click", () => {
      nav.classList.toggle("active");
    });
  }

  
  // Slideshow on hero section
  
  let slideIndex = 0;
  const slides = document.querySelectorAll(".slide");

  function showSlides() {
    if (!slides.length) return;

    slides.forEach(s => (s.style.display = "none"));

    slideIndex++;
    if (slideIndex > slides.length) slideIndex = 1;

    slides[slideIndex - 1].style.display = "block";
  }

  showSlides();
  setInterval(showSlides, 4000);

 
  // Promotion Ad Modal
  const modal_cancelbtn = document.getElementById("cancelbtn");
  const promotion_modal = document.querySelector(".promotion-modal");

  if (modal_cancelbtn && promotion_modal) {
    modal_cancelbtn.addEventListener("click", () => {
      promotion_modal.classList.add("deactivate");
    });
  }

 
  // Cart system
  let cart = [];

  const cartBtn = document.getElementById("cart-btn");
  const cartModal = document.querySelector(".cart-modal");
  const closeCart = document.getElementById("close-cart");
  const cartItems = document.getElementById("cart-items");
  const cartCount = document.getElementById("cart-count");

  const checkoutBtnFromCart = document.getElementById("checkout-from-cart");
  const checkoutModal = document.querySelector(".checkout-modal-form");
  const closeCheckout = document.getElementById("closebtn");

  const qtyInput = document.querySelector(
    '.order-info input[placeholder="Quantity"]'
  );
  const totalInput = document.querySelector(
    '.order-info input[placeholder="Total"]'
  );

  // Open cart modal when clicking cart button
  if (cartBtn && cartModal) {
    cartBtn.addEventListener("click", () => {
      cartModal.style.display = "flex";
    });
  }

  // close cart modal when clicking outside or on close button
  if (closeCart && cartModal) {
    closeCart.addEventListener("click", () => {
      cartModal.style.display = "none";
    });
  }

  // Open checkout modal when clicking "Place Order" button
  const placeOrderBtn = document.querySelector(".signbtn button");

  if (placeOrderBtn && checkoutModal) {
    placeOrderBtn.addEventListener("click", () => {
      checkoutModal.style.display = "flex";
      updateCheckout();
      updateReceiptLive();
    });
  }

  // Close checkout modal when clicking outside or on close button
  if (closeCheckout && checkoutModal) {
    closeCheckout.addEventListener("click", () => {
      checkoutModal.style.display = "none";
    });

    checkoutModal.addEventListener("click", (e) => {
      if (e.target === checkoutModal) {
        checkoutModal.style.display = "none";
      }
    });
  }

  const cancelCheckoutBtn = document.querySelector(".checkout-modal-form .cancel-btn");
  const checkoutForm = document.querySelector(".checkout-modal-form form");
  const checkoutMessage = document.getElementById("checkout-message");
  const successBox = document.querySelector(".checkout-success");
  const captchaCode = document.getElementById("captcha-code");
  const captchaInput = document.getElementById("captcha-input");
  const captchaResult = document.getElementById("captcha-result");
  let generatedCaptcha = "";

  function generateCaptcha() {
    const chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";
    generatedCaptcha = "";

    for (let i = 0; i < 5; i++) {
      generatedCaptcha += chars[Math.floor(Math.random() * chars.length)];
    }

    if (captchaCode) {
      captchaCode.textContent = generatedCaptcha;
    }
  }

  window.validateCaptcha = function () {
    if (!captchaInput || !captchaResult) return;

    if (captchaInput.value.trim().toUpperCase() === generatedCaptcha) {
      captchaResult.textContent = "Captcha verified";
      captchaResult.style.color = "green";
    } else {
      captchaResult.textContent = "Wrong captcha";
      captchaResult.style.color = "red";
    }
  };

  generateCaptcha();

  if (cancelCheckoutBtn && checkoutModal) {
    cancelCheckoutBtn.addEventListener("click", () => {
      checkoutModal.style.display = "none";
      if (checkoutForm) {
        checkoutForm.reset();
      }
    });
  }

  if (checkoutForm) {
    checkoutForm.addEventListener("submit", (e) => {
      e.preventDefault();

      const accountInput = document.querySelector('.user-card-info input[placeholder="Account Number"]');
      const cvvInput = document.querySelector('.user-card-info input[placeholder="CVV"]');
      const expiryInput = document.querySelector('.user-card-info input[placeholder="Expiry Date"]');
      const cardHolderInput = document.querySelector('.user-card-info input[placeholder="Card Holder"]');
      const fullNameInput = document.querySelector('.user-info input[placeholder="Full Name"]');
      const emailInput = document.querySelector('.user-info input[placeholder="Email"]');
      const addressInput = document.querySelector('.user-info input[placeholder="Address"]');
      const phoneInput = document.querySelector('.user-info input[placeholder="Phone"]');

      let valid = true;

      if (!accountInput || accountInput.value.trim().length < 4) valid = false;
      if (!cvvInput || cvvInput.value.trim().length < 3) valid = false;
      if (!expiryInput || expiryInput.value.trim() === "") valid = false;
      if (!cardHolderInput || cardHolderInput.value.trim() === "") valid = false;
      if (!fullNameInput || fullNameInput.value.trim() === "") valid = false;
      if (!addressInput || addressInput.value.trim() === "") valid = false;
      if (!phoneInput || phoneInput.value.replace(/\D/g, "").length < 10) valid = false;
      if (!emailInput || !emailInput.value.includes("@") || !emailInput.value.includes(".")) valid = false;
      if (!captchaInput || captchaInput.value.trim().toUpperCase() !== generatedCaptcha) valid = false;

      if (!valid) {
        if (successBox) {
          successBox.classList.remove("show");
        }
        if (checkoutMessage) {
          checkoutMessage.textContent = "Order denied. Please fill in the correct details.";
          checkoutMessage.style.color = "red";
        }
        return;
      }

      if (successBox) {
        successBox.classList.add("show");
      }
      if (checkoutMessage) {
        checkoutMessage.textContent = "Order placed successfully!";
        checkoutMessage.style.color = "green";
      }

      cart = [];
      updateCart();
      checkoutForm.reset();
      generateCaptcha();

      setTimeout(() => {
        checkoutModal.style.display = "none";
        if (successBox) {
          successBox.classList.remove("show");
        }
        if (checkoutMessage) {
          checkoutMessage.textContent = "";
        }
      }, 2000);
    });
  }

 
  // Add to cart functionality with quantity controls
  
  document.querySelectorAll(".cart-controls").forEach(control => {

    const addBtn = control.querySelector(".add-btn");
    const qtyBox = control.querySelector(".qty-controls");
    const qty = control.querySelector(".qty");
    const minus = control.querySelector(".minus");
    const plus = control.querySelector(".plus");

    let count = 1;

    if (!addBtn || !qtyBox) return;

   
    addBtn.addEventListener("click", (e) => {

      const card = e.target.closest(".s-card");
      if (!card) return;

      const name = card.querySelector("h3")?.innerText || "Item";

      const priceText =
        card.querySelectorAll("p")[1]?.innerText || "0";
      const price =
        parseFloat(priceText.replace(/[^0-9]/g, "")) || 0;

      let existing = cart.find(item => item.name === name);

      if (existing) {
        existing.qty += count;
      } else {
        cart.push({
          name,
          price,
          qty: count
        });
      }

      // reset upon adding to cart
      count = 1;
      qty.textContent = 1;
      qtyBox.classList.add("hidden");

      updateCart();
    });

    // Show quantity controls when add button is clicked
    addBtn.addEventListener("click", () => {
      qtyBox.classList.remove("hidden");
    });

    // plus/minus controls
    plus.addEventListener("click", () => {
      count++;
      qty.textContent = count;
    });

    minus.addEventListener("click", () => {
      if (count > 1) {
        count--;
        qty.textContent = count;
      }
    });
  });


  // Update cart display and checkout info
  function updateCart() {
    if (cartCount) {
      cartCount.innerText = cart.reduce((s, i) => s + i.qty, 0);
    }

    if (cartItems) {
      cartItems.innerHTML = "";

      cart.forEach((item, index) => {
        const div = document.createElement("div");

        div.innerHTML = `
          <p>${item.name}</p>
          <p>Qty: ${item.qty}</p>
          <p>MWK ${item.price * item.qty}</p>
          <button onclick="removeItem(${index})">Remove</button>
        `;

        cartItems.appendChild(div);
      });
    }

    updateCheckout();
  }


  // Update checkout info (quantity and total price)
 
  function updateCheckout() {
    let totalQty = cart.reduce((s, i) => s + i.qty, 0);
    let totalPrice = cart.reduce((s, i) => s + i.price * i.qty, 0);

    if (qtyInput) qtyInput.value = totalQty;
    if (totalInput) totalInput.value = "MWK " + totalPrice;
  }


  // Receipt Live Update
  
  function updateReceiptLive() {
    const receiptBox = document.querySelector(".receipt-info");
    if (!receiptBox) return;

    let name =
      document.querySelector(
        '.user-info input[placeholder="Full Name"]'
      )?.value || "";

    let phone =
      document.querySelector(
        '.user-info input[placeholder="Phone"]'
      )?.value || "";

    let address =
      document.querySelector(
        '.user-info input[placeholder="Address"]'
      )?.value || "";

    let subtotal = 0;
    let totalQty = 0;

    let html = `
      <div class="receipt-box">
        <h3>Bean Boutique Invoice</h3>
        <p><b>Name:</b> ${name}</p>
        <p><b>Phone:</b> ${phone}</p>
        <p><b>Address:</b> ${address}</p>
        <hr>
    `;

    if (cart.length === 0) {
      html += "<p>No items ordered</p>";
    } else {
      cart.forEach(item => {
        let itemTotal = item.price * item.qty;
        subtotal += itemTotal;
        totalQty += item.qty;

        html += `
          <div class="receipt-item">
            <span>${item.name} x${item.qty}</span>
            <span>MWK ${itemTotal}</span>
          </div>
        `;
      });

      html += `
        <hr>
        <div class="receipt-total">
          <p>Total Items: ${totalQty}</p>
          <p><b>Total: MWK ${subtotal}</b></p>
        </div>
      `;
    }

    html += `</div>`;
    receiptBox.innerHTML = html;
  }

  // Input listeners for live receipt update
  document
    .querySelectorAll(".user-info input, .order-info input")
    .forEach(input => {
      input.addEventListener("input", updateReceiptLive);
    });

  
  // Remove item from cart
 
  window.removeItem = function (index) {
    cart.splice(index, 1);
    updateCart();
  };

  // Checkout from cart
  
  if (checkoutBtnFromCart && checkoutModal) {
    checkoutBtnFromCart.addEventListener("click", () => {
      checkoutModal.style.display = "flex";
      updateCheckout();
      updateReceiptLive();
    });
  }

});