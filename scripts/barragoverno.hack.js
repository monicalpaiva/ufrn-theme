$(document).ready(function () {
    var links = $("#barra-brasil a");
    for (var i = 0; i < links.length; i++) {
        var $link = $(links[i]);
        if ($link.attr("href") != "#" && !$link.attr("target")) {
            $link.attr("target", "_blank");
        }
    }
});
//# sourceMappingURL=barragoverno.hack.js.map