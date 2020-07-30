import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ChoixMenu{
  final Text title;
  final Icon icon;
  
  const ChoixMenu({this.title, this.icon});
}

List<ChoixMenu> choices = <ChoixMenu>[
  const ChoixMenu(
    title: const Text('Informations'), 
    icon: const Icon(Icons.info_outline)
  ),
  const ChoixMenu(
    title: const Text('Partager'), 
    icon: const Icon(Icons.share)
  ),
];