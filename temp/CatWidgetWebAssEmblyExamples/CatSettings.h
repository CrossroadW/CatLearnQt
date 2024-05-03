﻿#ifndef CATSETTINGS_H
#define CATSETTINGS_H

#include <QWidget>

namespace Ui {
class CatSettings;
}

class CatSettings : public QWidget
{
    Q_OBJECT

public:
    explicit CatSettings(QWidget *parent = nullptr);
    ~CatSettings();

private:
    void InitUi();
    void InitProperty();
    void InitConnect();
    void InitSettings();

    void UpdateStyle();

protected:
    void showEvent(QShowEvent *event) override;
    void changeEvent(QEvent *event) override;
    void resizeEvent(QResizeEvent *event) override;

private:
    Ui::CatSettings *ui;
    bool m_bShowWidget;
};

#endif // CATSETTINGS_H
