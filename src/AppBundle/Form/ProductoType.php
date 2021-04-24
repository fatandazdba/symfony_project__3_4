<?php

namespace AppBundle\Form;

use Doctrine\DBAL\Types\FloatType;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Ivory\CKEditorBundle\Form\Type\CKEditorType;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\MoneyType;

class ProductoType extends AbstractType
{
    /**
     * {@inheritdoc}
     */
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('nombre', TextType::class)
            //->add('descripcion', CKEditorType::class, array('attr' => array('class' => 'form-control')))
            ->add('descripcion', TextareaType::class)
            ->add('precio', MoneyType::class)
            //->add('categoria')
            ->add('categoria', EntityType::class, array('class'=>'AppBundle:Categoria'))
            ->add('accesorios', EntityType::class, array('class'=>'AppBundle:Accesorio', 'multiple' => true))
            ->add('foto', FileType::class, array('attr' => array('onchange' => 'onChange(event)')))
            //->add('fechaCreacion', DateType::class)
            //->add('top')
            ->add('Guardar', SubmitType::class, array('label'=>'Nuevo producto'));
    }

    /**
     * {@inheritdoc}
     */
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array(
            'data_class' => 'AppBundle\Entity\Producto'
        ));
    }

}