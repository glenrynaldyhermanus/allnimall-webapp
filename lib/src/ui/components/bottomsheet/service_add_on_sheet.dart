import 'package:allnimall_web/src/core/extensions/double_ext.dart';
import 'package:allnimall_web/src/core/extensions/widget_iterable_ext.dart';
import 'package:allnimall_web/src/core/utils/functions/is_addon_exists_in_cart.dart';
import 'package:allnimall_web/src/data/models/order_service.dart';
import 'package:allnimall_web/src/data/models/service.dart';
import 'package:allnimall_web/src/data/models/service_add_on.dart';
import 'package:allnimall_web/src/data/services/cart/cart_service.dart';
import 'package:allnimall_web/src/ui/components/text/georama_text.dart';
import 'package:allnimall_web/src/ui/components/text/rocko_text.dart';
import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:customizable_counter/customizable_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ServiceAddOnSheet extends StatefulWidget {
  const ServiceAddOnSheet(
      {super.key, required this.service, required this.carts});

  final ServiceModel service;
  final List<OrderServiceModel> carts;

  @override
  ServiceAddOnSheetState createState() => ServiceAddOnSheetState();
}

class ServiceAddOnSheetState extends State<ServiceAddOnSheet> {
  OrderServiceModel? selectedOrder;

  @override
  void initState() {
    super.initState();

    for (var cart in widget.carts) {
      if (cart.serviceUid == widget.service.id) {
        selectedOrder = cart;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AllnimallColors.backgroundPrimary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: SingleChildScrollView(
          child: StickyHeader(
            header: SheetHeader(
                title: widget.service.name,
                description: widget.service.description,
                fee: widget.service.fee),
            content: SheetContent(
              service: widget.service,
              selectedOrder: selectedOrder,
            ),
          ),
        ),
      ),
    );
  }
}

class SheetHeader extends StatelessWidget {
  const SheetHeader({
    super.key,
    required this.title,
    required this.description,
    required this.fee,
  });

  final String title;
  final String description;
  final double fee;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AllnimallColors.backgroundPrimary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: Container(
                  width: 50,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 16, 8, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
                Expanded(
                  child: RockoText(
                    title,
                    fontSize: 16,
                  ),
                ),
                const Gap(16),
                GeoramaText(
                  fee.toRupiahString(),
                  fontSize: 14,
                  color: AllnimallColors.secondary,
                ),
                const Gap(16),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.black12,
          ),
        ],
      ),
    );
  }
}

class SheetContent extends ConsumerStatefulWidget {
  const SheetContent(
      {super.key, required this.service, required this.selectedOrder});

  final ServiceModel service;
  final OrderServiceModel? selectedOrder;

  @override
  ConsumerState<SheetContent> createState() => _SheetContentState();
}

class _SheetContentState extends ConsumerState<SheetContent> {
  int quantity = 1;

  List<ServiceAddOnModel> addOns = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.selectedOrder != null) {
      quantity = widget.selectedOrder!.quantity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.service.addOns!.isNotEmpty)
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 24, right: 24, top: 8),
                child: GeoramaText(
                  'Kamu bisa pilih layanan tambahan di bawah ini (opsional)',
                  fontSize: 14,
                ),
              ),
              ...List.generate(
                widget.service.addOns!.length,
                (index) => ServiceAddOnsRow(
                  service: widget.service,
                  serviceAddOn: widget.service.addOns![index],
                  initialValue: widget.selectedOrder == null
                      ? false
                      : isAddOnExistsInCart(widget.selectedOrder!.addOns,
                          widget.service.addOns![index].id!),
                  onSelected: (selected) {
                    if (selected) {
                      addOns.add(widget.service.addOns![index]);
                    } else {
                      addOns.remove(widget.service.addOns![index]);
                    }
                  },
                ),
              ).addToEnd(const Gap(4)),
              const Divider(
                thickness: 1,
                color: Colors.black12,
              ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: [
              const Expanded(
                child: GeoramaText(
                  'Jumlah pet',
                  fontSize: 14,
                ),
              ),
              CustomizableCounter(
                showButtonText: false,
                borderColor: Colors.transparent,
                borderRadius: 32,
                borderWidth: 1,
                textColor: AllnimallColors.primary,
                textSize: 14,
                step: 1,
                count: quantity.toDouble(),
                minCount: 0,
                maxCount: 8,
                incrementIcon: const Icon(
                  Icons.add_circle,
                  color: AllnimallColors.secondary,
                ),
                decrementIcon: const Icon(
                  Icons.remove_circle,
                  color: AllnimallColors.secondary,
                ),
                onCountChange: (count) {
                  setState(() {
                    quantity = count.toInt();
                  });
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: ElevatedButton(
            onPressed: () {
              if (quantity == 0) {
                ref
                    .read(cartServiceProvider.notifier)
                    .removeServiceFromCart(widget.service.id);
              } else {
                ref.read(cartServiceProvider.notifier).addServiceToCart(
                    widget.service.id,
                    widget.service.categoryName,
                    widget.service.fee,
                    widget.service.name,
                    quantity,
                    addOns);
              }

              context.pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AllnimallColors.primary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: GeoramaText(
                'Masukkan ke cart',
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ServiceAddOnsRow extends StatefulWidget {
  const ServiceAddOnsRow({
    super.key,
    required this.service,
    required this.serviceAddOn,
    required this.onSelected,
    this.initialValue = false,
  });

  final ServiceModel service;
  final ServiceAddOnModel serviceAddOn;
  final bool initialValue;
  final Function(bool selected) onSelected;

  @override
  State<ServiceAddOnsRow> createState() => _ServiceAddOnsRowState();
}

class _ServiceAddOnsRowState extends State<ServiceAddOnsRow> {
  bool isSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSelected = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Row(
        children: [
          Expanded(
            child: GeoramaText(
              widget.serviceAddOn.name,
              fontSize: 14,
            ),
          ),
          GeoramaText(
            "+ ${widget.serviceAddOn.fee.toRupiahString()}",
            fontSize: 12,
          ),
        ],
      ),
      value: isSelected,
      onChanged: (selected) {
        widget.onSelected(selected ?? false);
        setState(() {
          isSelected = selected!;
        });
      },
    );
  }
}
