import 'package:flutter/material.dart';
import '../models/proposal.dart';

class ProposalFormScreen extends StatefulWidget {
  final Proposal? existingProposal;

  const ProposalFormScreen({super.key, this.existingProposal});

  @override
  State<ProposalFormScreen> createState() => _ProposalFormScreenState();
}

class _ProposalFormScreenState extends State<ProposalFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _clientController;
  late TextEditingController _overviewController;
  late TextEditingController _objectivesController;
  late TextEditingController _scopeController;
  late TextEditingController _timelineController;
  late TextEditingController _budgetController;

  @override
  void initState() {
    super.initState();
    final p = widget.existingProposal;
    _titleController = TextEditingController(text: p?.title ?? '');
    _clientController = TextEditingController(text: p?.clientName ?? '');
    _overviewController = TextEditingController(text: p?.overview ?? '');
    _objectivesController = TextEditingController(text: p?.objectives ?? '');
    _scopeController = TextEditingController(text: p?.scope ?? '');
    _timelineController = TextEditingController(text: p?.timeline ?? '');
    _budgetController = TextEditingController(text: p?.budget ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _clientController.dispose();
    _overviewController.dispose();
    _objectivesController.dispose();
    _scopeController.dispose();
    _timelineController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final newProposal = Proposal(
        id: widget.existingProposal?.id,
        title: _titleController.text,
        clientName: _clientController.text,
        overview: _overviewController.text,
        objectives: _objectivesController.text,
        scope: _scopeController.text,
        timeline: _timelineController.text,
        budget: _budgetController.text,
        createdAt: widget.existingProposal?.createdAt,
      );
      Navigator.pop(context, newProposal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingProposal == null ? 'New Proposal' : 'Edit Proposal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Project Title'),
                  validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _clientController,
                  decoration: const InputDecoration(labelText: 'Client Name'),
                  validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _overviewController,
                  decoration: const InputDecoration(
                    labelText: 'Executive Overview',
                    alignLabelWithHint: true,
                  ),
                  maxLines: 4,
                  validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _objectivesController,
                  decoration: const InputDecoration(
                    labelText: 'Objectives',
                    alignLabelWithHint: true,
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _scopeController,
                  decoration: const InputDecoration(
                    labelText: 'Scope of Work',
                    alignLabelWithHint: true,
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _timelineController,
                  decoration: const InputDecoration(
                    labelText: 'Timeline',
                    alignLabelWithHint: true,
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _budgetController,
                  decoration: const InputDecoration(
                    labelText: 'Budget / Pricing',
                    alignLabelWithHint: true,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveForm,
                    child: const Text('Save Proposal'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
