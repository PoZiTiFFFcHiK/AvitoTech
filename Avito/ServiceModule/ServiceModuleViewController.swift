//
//  ServiceModuleViewController.swift
//  Avito
//
//  Created by Владимир on 18.01.2021.
//  
//

import UIKit

final class ServiceModuleViewController: UIViewController {
	private let output: ServiceModuleViewOutput
    private let titleLabel = UILabel()
    private var image = UIImageView()
    private let scroll = UIScrollView()
    private let stack = UIStackView()
    private let selectButton = UIButton()
    
    private var topTitle = ""
    private var actionTitle = ""
    private var selectedActionTitle = ""
    private var servicesList = [ServiceInfo]()
    private var leftImageData = Data()
    
    private var imagePresented = false
    private var selectedButton = UIButton()
    
    init(output: ServiceModuleViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
	}
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        self.image = UIImageView(image: #imageLiteral(resourceName: "CloseIconTemplate"))
        
        view.addSubview(self.image)
        
        view.addSubview(self.titleLabel)
        
        self.output.loadData()
        
        setupViews()
        
        view.addSubview(self.scroll)
        
        scroll.addSubview(self.stack)
        
        for model in servicesList {
            if model.isSelected {
                let serviceButton = UIButton()
                makeButton(buttonModel: model, button: serviceButton)
                stack.addArrangedSubview(serviceButton)
                buttonConstraintsInit(view: stack, button: serviceButton)
            }
        }
        
        view.addSubview(self.selectButton)
        
        constraintsInit(view: view)
        
        self.view = view
    }
    
    private func setupViews() {
        self.image.translatesAutoresizingMaskIntoConstraints = false
        
        self.titleLabel.text = self.topTitle
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 35)
        self.titleLabel.lineBreakMode = .byWordWrapping
        self.titleLabel.numberOfLines = 0
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.scroll.translatesAutoresizingMaskIntoConstraints = false
        
        self.stack.axis = .vertical
        self.stack.spacing = 10
        self.stack.translatesAutoresizingMaskIntoConstraints = false
        
        self.selectButton.setTitle("Выбрать", for: .normal)
        self.selectButton.backgroundColor = UIColor(red: 0.06, green: 0.64, blue: 0.89, alpha: 1)
        self.selectButton.layer.cornerRadius = 10
        self.selectButton.setTitleColor(.white, for: .normal)
        self.selectButton.addTarget(self, action: #selector(selectButtonPressed), for: .touchUpInside)
        self.selectButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func makeButton(buttonModel: ServiceInfo, button: UIButton) {
        let attributesTitle = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)]
        let attributedStringTitle = NSMutableAttributedString(string: buttonModel.title + "\n", attributes: attributesTitle)
        let attributesPrice = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 22)]
        let attributedStringPrice = NSMutableAttributedString(string: "\n\n" + buttonModel.price, attributes: attributesPrice)
        let descriptionString = NSMutableAttributedString(string: buttonModel.description ?? "")
        attributedStringTitle.append(descriptionString)
        attributedStringTitle.append(attributedStringPrice)
        
        button.setAttributedTitle(attributedStringTitle, for: .normal)
        button.titleLabel!.lineBreakMode = .byWordWrapping
        button.titleLabel!.numberOfLines = 0
        button.backgroundColor = UIColor(red: 0.96, green: 0.95, blue: 0.95, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(serviceButtonTapped), for: .touchUpInside)
        
        self.output.getImage(url: buttonModel.icon, button: button)
        
        let rightImageView = UIImageView(image: #imageLiteral(resourceName: "checkmark"))
        rightImageView.translatesAutoresizingMaskIntoConstraints = false
        rightImageView.isHidden = true
        button.addSubview(rightImageView)
    }
    
    @objc func serviceButtonTapped(sender: UIButton) {
        if sender == selectedButton {
            sender.subviews[1].isHidden = true
            selectedButton = UIButton()
            imagePresented = false
            return
        }
        
        if imagePresented {
            selectedButton.subviews[1].isHidden = true
            sender.subviews[1].isHidden = false
        } else {
            sender.subviews[1].isHidden = false
            imagePresented = true
        }
        selectedButton = sender
    }
    
    @objc func selectButtonPressed(sender: UIButton) {
        let buttonTitle = selectedButton.titleLabel?.text
        let nIndex = buttonTitle?.firstIndex(of: "\n")
        let title = buttonTitle?.prefix(upTo: nIndex!) ?? "Вы не выбрали сервис"
        self.output.didSelectButtonPressed(title: String(title))
    }
    
    private func constraintsInit(view: UIView) {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            image.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            image.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant : -20),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            
            stack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            stack.topAnchor.constraint(equalTo: scroll.topAnchor),
            stack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            
            stack.widthAnchor.constraint(equalTo: scroll.widthAnchor),
            
            selectButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            selectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selectButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            selectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func buttonConstraintsInit(view: UIView, button: UIButton) {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.subviews[0].topAnchor.constraint(equalTo: button.topAnchor, constant: 20),
            button.subviews[0].leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 80),
            button.subviews[0].bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -20),
            button.subviews[0].trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -40),
            button.subviews[1].topAnchor.constraint(equalTo: button.topAnchor, constant: 40),
            button.subviews[1].leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: -40)
        ])
    }
}

extension ServiceModuleViewController: ServiceModuleViewInput {
    func getData(firstTitle: String, actionTitle: String, selectedActionTitle: String, servicesInfo: [ServiceInfo]) {
        self.topTitle = firstTitle
        self.actionTitle = actionTitle
        self.selectedActionTitle = selectedActionTitle
        self.servicesList = servicesInfo
    }
    
    func getImageDataToView(imageData: Data, button: UIButton) {
        self.leftImageData = imageData
        let leftImage = UIImage(data: self.leftImageData)
        let leftImageView = UIImageView(image: leftImage)
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(leftImageView)
        
        NSLayoutConstraint.activate([
            button.subviews[2].topAnchor.constraint(equalTo: button.topAnchor, constant: 20),
            button.subviews[2].trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: 70)
        ])
    }
}
