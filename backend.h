#ifndef BACKEND_H
#define BACKEND_H

#include <QtCore/QObject>


typedef QString Dom;


class Backend : public QObject {
    Q_OBJECT

    Q_PROPERTY(QString map READ map WRITE setMap NOTIFY mapChanged)

public:
    Backend(QObject* parent = nullptr);
    ~Backend();

    QString map();
    void setMap(const QString &map);

signals:
    void mapChanged();

public slots:
    void onLayerAdd(const Dom& dom);
    void onLayerChange(const Dom& dom);
    void onLayerDelete(const Dom& dom);
    //void onColorChange(const Dom& dom);
    void onSuitabilityMapAdd(const Dom& dom);
    void onSuitabilityMapDelete(const Dom& dom);
    void onSuitabilityMapChange(const Dom& dom);
    void onSuitabilityMapActive(const Dom& dom);
    void onSelectFeatureSets(const Dom& dom);
    void onRefreshModel(const Dom& dom);

private:
    QString m_map;
};

#endif // BACKEND_H
