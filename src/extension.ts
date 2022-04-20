import * as vscode from "vscode";

export function activate(context: vscode.ExtensionContext) {
  //   const sidebarProvider = new SidebarProvider(context.extensionUri);
  //   context.subscriptions.push(
  //     vscode.window.registerWebviewViewProvider(
  //       "grpc-rocket-sidebar",
  //       sidebarProvider
  //     )
  //   );
  let disposable = vscode.commands.registerCommand(
    "grpc-rocket.helloWorld",
    () => {
      vscode.window.showInformationMessage("Hello World from gRPC rocket!");
    }
  );

  context.subscriptions.push(disposable);
}

export function deactivate() {}
