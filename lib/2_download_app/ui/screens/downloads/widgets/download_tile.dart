import 'package:flutter/material.dart';

import 'download_controler.dart';

class DownloadTile extends StatelessWidget {
  const DownloadTile({super.key, required this.controller});

  final DownloadController controller;

  // TODO

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(controller.ressource.name),
            subtitle: _buildSubtitle(),
            trailing: _buildIcon(),
          ),
        );
      },
    );
  }

  // TODO
  Widget? _buildSubtitle() {
    if (controller.status == DownloadStatus.notDownloaded) return null;

    final downloaded = (controller.progress * controller.ressource.size)
        .toStringAsFixed(1);

    final total = controller.ressource.size;

    final percent = (controller.progress * 100).toStringAsFixed(1);

    return Text("$percent completed - $downloaded of $total");
  }

  Widget? _buildIcon() {
    switch (controller.status) {
      case DownloadStatus.notDownloaded:
        return IconButton(
          icon: Icon(Icons.download),
          onPressed: () => controller.startDownload(),
        );
      case DownloadStatus.downloading:
        return Icon(Icons.autorenew);
      case DownloadStatus.downloaded:
        return Icon(Icons.folder);
    }
  }
}
