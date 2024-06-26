//
//  ContentView.swift
//  Instafilter
//
//  Created by Ahmed Adel on 15/04/2024.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI
import PhotosUI
import StoreKit

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingConfirmation = false
    @State private var isControlPanelOn = false
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                //Image Area
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                } .onChange(of: selectedItem, loadImage)
                .buttonStyle(.plain)
                
                Spacer()
                HStack {
                    Text("Radius")
                    Slider(value: $filterRadius)
                        .disabled(isControlPanelOn == false)
                    
                }
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .disabled(isControlPanelOn == false)
                    
                }
                .onChange(of: filterIntensity, applyProcessing)
                .onChange(of: filterRadius, applyProcessing)
                HStack {
                    Button("Change filter" , action: changeFilter)
                        .disabled(isControlPanelOn == false)
                    
                    Spacer()
                    
                    // Share link
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter Image", image: processedImage))
                    }
                }
                
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingConfirmation) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Bloom") { setFilter(CIFilter.bloom())}
                Button("Color Invert") { setFilter(CIFilter.colorInvert()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    func changeFilter() {
        showingConfirmation = true
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
            
            // To enable image controls
            isControlPanelOn = true
        }
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputSaturationKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputSaturationKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        guard let outputImage = currentFilter.outputImage else {return}
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
        
    }
    
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        
        filterCount += 1
        
        if filterCount >= 20 {
            requestReview()
        }
    }
}

#Preview {
    ContentView()
}
