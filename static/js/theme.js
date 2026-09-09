document.addEventListener('DOMContentLoaded', () => {
    initScrollAnimations();

    const container = document.querySelector('.hero-right');

    if (container) {
        container.querySelectorAll('a, button, input, textarea, select, [tabindex]')
            .forEach(el => el.setAttribute('tabindex', '-1'));
    }
})

function initScrollAnimations() {
    initRevealOnScroll();
}

function initRevealOnScroll() {
    const reveals = document.querySelectorAll('.reveal');
    if (reveals.length === 0) return;

    // Under reduced motion `motion.css` already shows these unconditionally.
    // Marking them active as well keeps the DOM in the state the rest of the
    // page expects, and saves running an observer whose only job would be to
    // reproduce what the stylesheet has already done.
    if (window.motionPrefs?.reduced) {
        reveals.forEach(reveal => reveal.classList.add('active'));
        return;
    }

    const isMobile = window.innerWidth <= 768;

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('active');
            }
        });
    }, {
        threshold: isMobile ? 0.05 : 0.1
    });

    reveals.forEach(reveal => {
        observer.observe(reveal);
    });
}
