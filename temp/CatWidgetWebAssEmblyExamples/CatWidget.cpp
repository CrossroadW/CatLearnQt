﻿#include "CatWidget.h"
#include "ui_CatWidget.h"
#include "CatConfig/CatConfig.h"
#include "CatControl/ListingOptions.h"

#include <QPushButton>
#include <QButtonGroup>
#include <QFile>


#include "WidgetTools/QrenCodeTool.h"
#include "WidgetTools/ImageTools.h"
#include "WidgetTools/SliderTools.h"
#include "WidgetTools/RimlessWindowTool.h"
#include "WidgetTools/PagingNavigationTools.h"
#ifndef Q_OS_IOS
#include "WidgetTools/CatQcustomplotTools.h"
#endif



CatWidget::CatWidget(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::CatWidget)
{
    ui->setupUi(this);
    InitUi();
    InitProperty();
    InitConnect();
}

CatWidget::~CatWidget()
{
    delete ui;
}

void CatWidget::InitUi()
{
    InitToolWidgets();
    InitToolButtons();
}

void CatWidget::InitProperty()
{
    m_pToolButtons["CatQrenCode"]->setChecked(true);

    UpdateStyle();
}

void CatWidget::InitConnect()
{
    connect(m_pToolListiongOptions->GetButtonGroup(), SIGNAL(buttonClicked(int)), this, SLOT(On_ToolButtons(int)));
    connect(CatConfig::Instance(), &CatConfig::UpdateStyleSheets, this, [=](){
        UpdateStyle();
    });

    m_pToolButtons["CatImageTools"]->setVisible(false);
}

void CatWidget::InitToolButtons()
{
    QVBoxLayout *layout_ToolOptions = new QVBoxLayout(ui->ToolWidget);
    layout_ToolOptions->setContentsMargins(0,5,0,5);
    layout_ToolOptions->setSpacing(0);
    m_pToolListiongOptions = new ListiongOptions(ListiongOptions::VBox, ui->ToolWidget);
    layout_ToolOptions->addWidget(m_pToolListiongOptions);

    static_cast<QVBoxLayout*>(m_pToolListiongOptions->GetButtonlayout())->setSpacing(2);

    QStringList ToolButtonList = {"CatQrenCode", "CatImageTools", "CatSliderTools", "CatRimlessWindowTool", "CatPagingNavigationTool"};
#ifndef Q_OS_IOS
    ToolButtonList << "CatQcustomplotTools";
#endif
    for(int i = 0; i < ToolButtonList.size(); i++)
    {
        QPushButton *button = new QPushButton(m_pToolListiongOptions->GetRootWidget());
        button->setObjectName(ToolButtonList[i]);
        m_pToolListiongOptions->AddButton(button, i);
        m_pToolButtons[ToolButtonList[i]] = button;
    }

    QSpacerItem* item = new QSpacerItem(50, 10, QSizePolicy::Minimum, QSizePolicy::Expanding);

    m_pToolListiongOptions->AddItem(item);
}

void CatWidget::InitToolWidgets()
{
    QrenCodeTool *m_pQrenCodeTool = new QrenCodeTool;
    m_pQrenCodeTool->setObjectName("CatWidgetQrenCodeTool");
    ui->ToolStackedWidget->addWidget(m_pQrenCodeTool);

    ImageTools *m_pImageTools = new ImageTools;
    ui->ToolStackedWidget->addWidget(m_pImageTools);

    SliderTools *m_pSliderTools = new SliderTools;
    ui->ToolStackedWidget->addWidget(m_pSliderTools);

    RimlessWindowTool *m_pRimlessWindowTool = new RimlessWindowTool;
    m_pRimlessWindowTool->setObjectName("CatRimlessWindowTool");
    ui->ToolStackedWidget->addWidget(m_pRimlessWindowTool);
    m_pRimlessWindowTool->installEventFilter(this);
    m_pRimlessWindowTool->setMouseTracking(true);

    PagingNavigationTools *m_pPagingNavigationTools = new PagingNavigationTools;
    m_pPagingNavigationTools->setObjectName("PagingNavigationTools");
    ui->ToolStackedWidget->addWidget(m_pPagingNavigationTools);
    m_pPagingNavigationTools->installEventFilter(this);
    m_pPagingNavigationTools->setMouseTracking(true);

#ifndef Q_OS_IOS
    CatQcustomplotTools *m_pCatQcustomplotTools = new CatQcustomplotTools;
    m_pCatQcustomplotTools->setObjectName("CatQcustomplotTools");
    ui->ToolStackedWidget->addWidget(m_pCatQcustomplotTools);
    m_pCatQcustomplotTools->installEventFilter(this);
    m_pCatQcustomplotTools->setMouseTracking(true);
#endif

    ui->ToolStackedWidget->setMouseTracking(true);
}

void CatWidget::UpdateStyle()
{
    QString stylePath;
stylePath = ":/qss/" + CatConfig::GetStyle() + "/";

    QFile file_1(stylePath + "ListingOptionCatWidgetTool.css");
    file_1.open(QIODevice::ReadOnly);
    QString stylehoot_1 = QLatin1String(file_1.readAll());
    m_pToolListiongOptions->setStyleSheet(stylehoot_1);
    file_1.close();

    QFile file_0(stylePath + "CatWidget.css");
    file_0.open(QIODevice::ReadOnly);
    QString stylehoot_0 = QLatin1String(file_0.readAll());
    this->setStyleSheet(stylehoot_0);
    file_0.close();


}

void CatWidget::On_ToolButtons(int id)
{
    ui->ToolStackedWidget->setCurrentIndex(id);
}

bool CatWidget::eventFilter(QObject *watched, QEvent *event)
{
    if(watched->objectName() == "CatRimlessWindowTool")
    {
        watched->eventFilter(watched, event);
    }
    return QWidget::eventFilter(watched, event);
}
