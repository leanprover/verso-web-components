/*
 * One place that decides whether this page should animate.
 *
 * Two separate questions get answered here, because they have different
 * answers and different consequences:
 *
 *  * `reduce-motion` — the visitor asked for less movement, or the device is
 *    weak enough that movement will stutter rather than delight. Everything
 *    that travels, fades or springs is cut; the layout it was decorating stays
 *    exactly where it was.
 *
 *  * `low-power` — the device is cheap. On top of the above, the effects that
 *    cost a compositor pass on every frame (backdrop blurs, filter blurs) are
 *    dropped, because those are what turn a scroll into a slideshow on a
 *    budget phone even when nothing is moving.
 *
 * The classes land on <html> from a blocking `<head>` script, so the first
 * paint already has them and there is no burst of motion before the page
 * settles. `motion.css` reads them; the animation scripts read
 * `window.motionPrefs`.
 *
 * Escape hatch: `<html data-motion="full">` opts a page out of all of this.
 */
(function () {
    var root = document.documentElement;

    function mq(query) {
        return window.matchMedia ? window.matchMedia(query) : null;
    }

    var prefersReduced = mq('(prefers-reduced-motion: reduce)');
    var coarsePointer = mq('(pointer: coarse)');

    function connection() {
        return navigator.connection || navigator.mozConnection || navigator.webkitConnection || null;
    }

    /*
     * Device memory and core count are only consulted behind a coarse pointer.
     * Plenty of perfectly capable laptops report four cores and 4 GB — it is
     * the combination of those numbers *and* a touch screen that says "phone
     * that will drop frames".
     *
     * Save-Data is a request rather than a measurement, so it counts on its
     * own, whatever the device.
     */
    function detectLowPower() {
        var conn = connection();

        if (conn) {
            if (conn.saveData) return true;
            if (conn.effectiveType === 'slow-2g' || conn.effectiveType === '2g') return true;
        }

        if (!(coarsePointer && coarsePointer.matches)) return false;

        if (typeof navigator.deviceMemory === 'number' && navigator.deviceMemory <= 4) return true;
        if (typeof navigator.hardwareConcurrency === 'number' && navigator.hardwareConcurrency <= 4) return true;

        return false;
    }

    var optedOut = root.getAttribute('data-motion') === 'full';
    var lowPower = !optedOut && detectLowPower();
    var reduced = !optedOut && (lowPower || !!(prefersReduced && prefersReduced.matches));

    var listeners = [];

    function apply() {
        root.classList.toggle('reduce-motion', reduced);
        root.classList.toggle('low-power', lowPower);
    }

    function refresh() {
        var wasReduced = reduced;
        var wasLowPower = lowPower;

        lowPower = !optedOut && detectLowPower();
        reduced = !optedOut && (lowPower || !!(prefersReduced && prefersReduced.matches));

        if (reduced === wasReduced && lowPower === wasLowPower) return;

        apply();
        for (var i = 0; i < listeners.length; i++) listeners[i](window.motionPrefs);
    }

    apply();

    window.motionPrefs = {
        get reduced() { return reduced; },
        get lowPower() { return lowPower; },

        /* Run `fn` now and again whenever the answer changes. Scripts that only
           want to know once can read `.reduced` directly instead. */
        onChange: function (fn) {
            listeners.push(fn);
            fn(window.motionPrefs);
        }
    };

    /* The media query flips when the visitor changes the OS setting with the
       page open; Save-Data and effective type flip when the network does. */
    function listen(target, event) {
        if (!target) return;
        if (target.addEventListener) target.addEventListener(event, refresh);
        else if (target.addListener) target.addListener(refresh); // Safari < 14
    }

    listen(prefersReduced, 'change');
    listen(coarsePointer, 'change');
    listen(connection(), 'change');
})();
