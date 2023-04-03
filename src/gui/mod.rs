use gtk4::{Label, Box, CssProvider, StyleContext, ApplicationWindow, Application, Orientation, Button, Align};
use gtk4::gdk::Display;
use gtk4::prelude::*;

pub(crate) fn load_css() {
    let provider = CssProvider::new();
    provider.load_from_data(include_str!("styles.css"));

    StyleContext::add_provider_for_display(
        &Display::default().expect("Could not connect to a display."),
        &provider,
        gtk4::STYLE_PROVIDER_PRIORITY_APPLICATION,
    );
}

pub(crate) fn build_home(app: &Application) {
    let window = ApplicationWindow::builder()
        .application(app)
        .title("My OSX Application")
        .default_width(800)
        .default_height(400)
        .build();

    let home_box = Box::builder()
        .orientation(Orientation::Vertical)
        .build();

    let hello_world = Label::builder()
        .label("Hello World")
        .halign(Align::Center)
        .valign(Align::Center)
        .margin_top(50)
        .build();
    hello_world.add_css_class("hello_world");
    home_box.append(&hello_world);

    let button = Button::builder()
        .label("Press Me !!")
        .halign(Align::Center)
        .valign(Align::Center)
        .margin_top(50)
        .build();
    home_box.append(&button);

    window.set_child(Some(&home_box));
    window.show();
}