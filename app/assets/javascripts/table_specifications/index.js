//= require tables/general_methods
jQuery(function() {
  return $('.best_in_place').best_in_place();
});

$(function() {
  return $(document).on('click', '.photos a', function(evt) {
    $.ajax('table_specifications/table_specification/photos', {
      type: 'GET',
      dataType: 'script',
      data: {
        product_id: $(invoker).closest('tr').attr("product-id")
      },
      error: function(jqXHR, textStatus, errorThrown) {
        return console.log("AJAX Error: " + textStatus);
      },
      success: function(data, textStatus, jqXHR) {}
    });
    return false;
  });
});

$(function() {
  return $(document).on('click', '.size_images a', function(evt) {
    $.ajax('table_specifications/table_specification/size_images', {
      type: 'GET',
      dataType: 'script',
      data: {
        product_id: $(invoker).closest('tr').attr("product-id")
      },
      error: function(jqXHR, textStatus, errorThrown) {
        return console.log("AJAX Error: " + textStatus);
      },
      success: function(data, textStatus, jqXHR) {}
    });
    return false;
  });
});

$(function() {
  return $(document).on('click', '.factory a.invoker', function(evt) {
    $.ajax('table_specifications/table_specification/discounts', {
      type: 'GET',
      dataType: 'script',
      data: {
        factory_id: $(invoker).attr("id"),
        row_id: $(invoker).closest('tr').attr("row-id")
      },
      error: function(jqXHR, textStatus, errorThrown) {
        return console.log("AJAX Error: " + textStatus);
      },
      success: function(data, textStatus, jqXHR) {}
    });
    return false;
  });
});

$(function() {
  return $(document).on('click', '.v.v_table a.deliv.invoker', function(evt) {
    $.ajax('table_specifications/table_specification/deliveries', {
      type: 'GET',
      dataType: 'script',
      data: {
        row_id: $(invoker).closest('tr').attr("row-id")
      },
      error: function(jqXHR, textStatus, errorThrown) {
        return console.log("AJAX Error: " + textStatus);
      },
      success: function(data, textStatus, jqXHR) {
        return console.log("articles change");
      }
    });
    return false;
  });
});

$(function() {
  return $(document).on('click', 'a.shvg_percent, a.shvg.invoker', function(evt) {
    $.ajax('table_specifications/table_specification/packing_sizes', {
      type: 'GET',
      dataType: 'script',
      data: {
        product_id: $(invoker).closest('tr').attr("product-id"),
        id: $(invoker).closest('tr').attr("row-id")
      },
      error: function(jqXHR, textStatus, errorThrown) {
        return console.log("AJAX Error: " + textStatus);
      },
      success: function(data, textStatus, jqXHR) {
        console.log("articles change");
        return console.log($(invoker).closest('tr').attr("product-id"));
      }
    });
    return false;
  });
});

$(document).ready(function() {
  $("#form_button").click();
  activateBestInPlace("[data-bip-attribute='unit_price_factory']", 'main_table');
  activateBestInPlace("[data-bip-attribute='number_of']", 'main_table');
  activateBestInPlace("[data-bip-attribute='interest_percent']", 'main_table');
  activateBestInPlace("[data-bip-attribute='arhitec_percent']", 'main_table');
  $(document).on("click", "a.invoker", function() {
    var invoker;
    return invoker = $(this);
  });
  $("body").on("click", "#modalpict a", function() {
    var imgsrc, imgval, product_id, row_id;
    $("#modalpict").modal("hide");
    imgsrc = $(this).find("img").attr("src");
    $(invoker).find("img").attr("src", imgsrc);
    imgval = $(this).find("img").attr("value");
    if (imgsrc.substring(0, 10) !== "data:image") {
      $(invoker).find("img").attr("value", imgval);
      $("#table_specification_photo_id").val(imgval);
      $("#table_specification_photo_base64_form").val("");
    } else {
      row_id = $(invoker).closest("tr").attr("row-id");
      product_id = $(invoker).closest("tr").attr("product-id");
      if (product_id !== undefined) {
        $(invoker).closest("tr").find(".id_table").val(row_id);
        $(invoker).closest("tr").find(".product_id_table").val(product_id);
        $(invoker).closest("tr").find(".base64_table").val(imgsrc);
        $(invoker).closest("tr").find("input[name=add_photos]").trigger("click");
      }
      $(invoker).find("img").attr("value", "");
      $("#table_specification_photo_base64_form").val(imgsrc);
      $("#table_specification_photo_id").val("");
    }
    return false;
  });
  $("body").on("click", "#modalsize a", function() {
    var imgsrc, imgval, product_id, row_id;
    $("#modalsize").modal("hide");
    imgsrc = $(this).find("img").attr("src");
    $(invoker).find("img").attr("src", imgsrc);
    $("#table_specification_size_image_base64").val(imgsrc);
    imgval = $(this).find("img").attr("value");
    if (imgsrc.substring(0, 10) !== "data:image") {
      $("#table_specification_size_image_id").val(imgval);
      $("#table_specification_size_image_base64").val("");
    } else {
      product_id = $(invoker).closest("tr").attr("product-id");
      row_id = $(invoker).closest("tr").attr("row-id");
      if (product_id !== undefined) {
        $(invoker).closest("tr").find(".id_table").val(row_id);
        $(invoker).closest("tr").find(".product_id_table").val(product_id);
        $(invoker).closest("tr").find(".base64_table").val(imgsrc);
        $(invoker).closest("tr").find("input[name=add_size_images]").trigger("click");
      }
      $(invoker).find("img").attr("value", imgval);
      $("#table_specification_size_image_base64_form").val(imgsrc);
      $("#table_specification_size_image_id").val("");
    }
    return false;
  });
  $("body").on("click", "#modalfactory .btn-primary, #modalfactory_table .btn-primary", function() {
    var change_modal, current_discount, increment, row_id, set_discount;
    change_modal = $(invoker).closest("td");
    row_id = $(invoker).closest("tr").attr("row-id");
    if ($(change_modal).hasClass("factory")) {
      current_discount = modalSelect("modalfactory", "_table");
      $("#modalfactory_table").modal("hide");
      $(invoker).find("span").html(current_discount[0]);
      increment = $(".increment_discount_modal").val();
      console.log(row_id);
      if (row_id !== undefined) {
        set_discount = {
          table_specification: {
            discount_id: current_discount[1],
            increment_discount: increment
          }
        };
        ajaxCall('table_specifications/' + row_id, "PUT", "JSON", set_discount);
      }
      return calculate(invoker);
    } else {
      current_discount = modalSelect("modalfactory", "");
      $("#modalfactory").modal("hide");
      $(invoker).find("span").html(current_discount[0]);
      increment = $(".increment_discount_modal").val();
      $("#table_specification_discount_id").val(current_discount[1]);
      $(invoker).closest("tr").find(".table_specification_increment_discount").val(increment);
      $("#table_specification_increment_discount").val(increment);
      return calculate(invoker);
    }
  });
  $("body").on("click", "#modalv .btn-primary", function() {
    var d, h, pack, v, w;
    $("#modalv").modal("hide");
    w = $("#w").val();
    h = $("#h").val();
    d = $("#d").val();
    pack = $("#pack").val();
    v = w * h * d;
    v += v / 100 * pack;
    $("#uv").html(v);
    $("#product_width").val(w);
    $("#product_height").val(h);
    $("#product_depth").val(d);
    $("#table_specification_percent_v").val(pack);
    return calculate(invoker);
  });
  $("body").on("click", "#modalv_table .btn-primary", function() {
    var d, h, pack, row_id, set_percent_v, v, w;
    row_id = $(invoker).closest("tr").attr("row-id");
    w = $("#w").text();
    h = $("#h").text();
    d = $("#d").text();
    pack = $("#pack").val();
    v = w * h * d;
    v += v / 100 * pack;
    if (row_id !== undefined) {
      set_percent_v = {
        table_specification: {
          percent_v: pack
        }
      };
      ajaxCall('table_specifications/' + row_id, "PUT", "JSON", set_percent_v);
      $(invoker).siblings("input.unit_v").val(v);
    } else {
      $(invoker).siblings(".packing").html(pack);
      $("#uv").html(v);
      $("#table_specification_percent_v").val(pack);
      $("#product_unit_v").val("");
      $("#product_width").val(w);
      $("#product_height").val(h);
      $("#product_depth").val(d);
    }
    $("#modalv_table").modal("hide");
    return calculate(invoker);
  });
  $("body").on("click", "#modaldelivery .btn-primary, #modaldelivery_table .btn-primary", function() {
    var additional_delivery, additional_packaging, change_modal, current_discount, delivery_id, row_id, set_delivery;
    change_modal = $(invoker).closest("td");
    row_id = $(invoker).closest("tr").attr("row-id");
    if ($(change_modal).hasClass("v_table")) {
      delivery_id = modalSelect("modaldelivery", "_table");
      additional_packaging = $(".packingPrice").val();
      additional_delivery = $(".addToDelivery").val();
      console.log(additional_packaging);
      console.log(additional_delivery);
      $("#modaldelivery_table").modal("hide");
      if (row_id !== undefined) {
        set_delivery = {
          table_specification: {
            delivery_id: delivery_id[1],
            additional_packaging: additional_packaging,
            additional_delivery: additional_delivery
          }
        };
        ajaxCall('table_specifications/' + row_id, "PUT", "JSON", set_delivery);
      }
      $.ajax({
        url: "/deliveries/" + delivery_id[1],
        type: "GET",
        dataType: "JSON",
        success: function(data) {
          $(".cost").val(data.cost);
          $(".execution_document").val(data.execution_document);
          $(".check_factory").val(data.check_factory);
          $(".bank_service").val(data.bank_service);
          return $(".bank_percent").val(data.bank_percent);
        }
      });
      calculate(invoker);
      current_discount = modalSelect("modaldelivery", "");
      $("#modaldelivery").modal("hide");
      $("#table_specification_delivery_id").val($("#modaldelivery select :selected").val());
      $("#table_specification_additional_packaging").val($(".packingPrice").val());
      $("#table_specification_additional_delivery").val($(".addToDelivery").val());
      $(invoker).closest("tr").find(".delivery_id").val($("#modaldelivery select :selected").val());
      $(invoker).closest("tr").find(".packing").val($("#packingPrice").val());
      $(invoker).closest("tr").find(".add_to_delivery").val($("#addToDelivery").val());
      return calculate(invoker);
    }
  });
  $("input").on("change keyup", function() {
    return calculate($(this));
  });

  /*
  навешивание плагинов jquery*****
   */
  $("textarea").autoResize({
    extraSpace: 0
  });
  return $("table").stickyTableHeaders();
});

