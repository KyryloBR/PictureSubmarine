#include "image.h"

Image::Image(const QString &_source, QObject *parent) : QObject(parent)
{
    m_source = _source;
}

Image::Image(const Image &instance)
{
    m_source = instance.m_source;
}


QString &Image::sourceImage()
{
    return m_source;
}

void Image::setSourceImage(const QString &_source)
{
    m_source = _source;
}

